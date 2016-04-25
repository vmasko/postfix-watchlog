module Watchlog
  class Dispatcher
    attr_accessor :path, :sender

    def initialize(path)
      @path = path
      @sender = Sender.new
    end

    def run
      File.open(path) do |file|
        file.tail do |line|
          parser = Parser.new(line)
          sender.process(parser.data) if parser.bounced?
        end
      end
    end

  end
end
