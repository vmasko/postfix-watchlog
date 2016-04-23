module Watchlog

  class CLI
    class << self

      def start
        begin
          puts "\tService has started."
          Watchlog::Dispatcher.run
        rescue Interrupt
          puts "\tService stopped."
        end
      end

    end
  end
end
