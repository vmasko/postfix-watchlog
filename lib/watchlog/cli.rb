module Watchlog

  class CLI
    class << self

      def start
        begin
          Helper::text(:start)
          Dispatcher::run
        rescue Interrupt
          Helper::text(:interrupt)
        end
      end

    end
  end
end
