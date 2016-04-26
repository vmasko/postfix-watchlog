module Watchlog
  class Dispatcher
    MODE = ARGV[1] || 'send'
    attr_accessor :path, :handler

    def initialize(path)
      @path    = path
      @handler = type
    end

    def run
      File.open(path) do |file|
        examine(file) if mode('exam')
        tail(file)    if mode('send')
      end
    rescue Errno::ENOENT => message
      puts message
    end

    def examine(file)
      file.each_line { |line| parse(line) }
      handler.write
      exit
    end

    def tail(file)
      file.tail { |line| parse(line) }
    end

    def parse(line)
      parser = Parser.new(line)
      handler.process(parser.data) if parser.bounced?
    end

    def mode(name)
      MODE.include?(name)
    end

    def type
      mode('exam') ? Examiner.new : Sender.new
    end
  end
end
