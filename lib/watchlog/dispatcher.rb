module Watchlog
  class Dispatcher
    MODE = ARGV[1]
    attr_accessor :path, :handler

    def initialize(path)
      @path = path
      @handler = type
    end

    def run
      File.open(path) do |file|
        file.each_line { |line| parse(line) }; handler.write; exit if mode('examine')
        file.tail      { |line| parse(line) }
      end
    rescue Errno::ENOENT => message
      puts message
    end

    def parse(line)
      parser = Parser.new(line)
      handler.process(parser.data) if parser.bounced?
    end

    def mode(name)
      MODE.include?(name)
    end

    def type
      mode('examine') ? Examiner.new : Sender.new
    end
  end
end
