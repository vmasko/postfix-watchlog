module Bounce

  class CLI
    class << self

      def start
        begin
          puts "\tLog tracking has started..."
          puts "\tPress Ctrl-C to stop service."
          Bounce::Keeper.run($log_path)
        rescue Interrupt => e
          puts "\tService stopped."
        end
      end

    end
  end
end
