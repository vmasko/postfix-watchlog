module Bounce

  class Keeper
    class << self

      # Opens the file, passes it to the parse method
      def run
        begin
          File.open($log_path) do |log|
            puts "\tPress Ctrl-C to stop the service."
            parse(log)
          end
        rescue Errno::ENOENT
          puts "\tError: file not found. Check your load_path in the config file."
          exit
        end
      end

      # Parses each 10 lines matching the specified parameter,
      # extracts email or any string that fits the pattern
      def parse(log)
        arr = []
        log.tail do |line|
          pack(arr, line) if line.match /#{$line}/
        end
      end

      def pack(arr, line)
        arr << { line.match(/#{$string}/)[0] => Time.now.xmlschema }
        if arr.size >= 10
          Bounce::Sender.post(arr)
          arr.clear
        end
      end

    end
  end
end
