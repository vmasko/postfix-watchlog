module Watchlog
  class Dispatcher
    attr_accessor :path, :handler

    def initialize(path)
      @path = path
      ARGV[1] == 'test' ? @handler = Tester.new : @handler = Sender.new
    end

    def run
      File.open(path) do |file|
        test(file) if ARGV[1] == 'test'
        tail(file)
      end
    rescue Errno::ENOENT => message
      puts message
    end

    def test(file)
      file.each_line { |line| parse(line) }
      handler.write
      exit
    end

    def tail(file)
      file.seek(0, IO::SEEK_END)
      loop do
        changes = file.read
        changes.split("\n").each { |i| parse(i) } unless changes.empty?
      end
      sleep 1
    end

    def parse(line)
      parser = Parser.new(line)
      handler.process(parser.data) if parser.bounced?
    end
  end
end
