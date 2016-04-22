module Bounce

  class CLI
    class << self

      def start
        begin
          puts "\tService has started."
          Bounce::Keeper.run($log_path)
        rescue Interrupt
          puts "\tService stopped."
        end
      end

    end
  end
end
