module Watchlog
  class Dispatcher
    MODE = ARGV[1]
    attr_accessor :path, :handler

    def initialize(path)
      @path = path
      @handler = mode
    end

    def run
      File.open(path) do |file|
        file.each_line { |line| parse(line) }; handler.write; exit if MODE == 'analyzer'
        file.tail      { |line| parse(line) }
      end
    rescue Errno::ENOENT => message
      puts message
    end

    def parse(line)
      parser = Parser.new(line)
      handler.process(parser.data) if parser.bounced?
    end

    def mode
      MODE == 'analyzer' ? Analyzer.new : Sender.new
    end

  end
end
