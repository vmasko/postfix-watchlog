module Watchlog

  class Dispatcher
    class << self

      # Opens the file, passes it to the #parse
      def run
        begin
          File.open($log_path) do |log|
            puts "\tPress Ctrl-C to stop the service."
            parse(log)
          end
        rescue Errno::ENOENT
          puts "\tError: file not found. Check the $load_path in the config file."
          exit
        end
      end

      # Tails the file, grabs matching lines and passes them to the #pack
      def parse(log)
        arr = []
        begin
          log.tail do |line|
            pack(arr, line) if line.match /#{$line}/
          end
        rescue RegexpError
          puts "\tError: invalid regular expression."
          puts "\tCheck the $line pattern in the config file."
          exit
        end
      end

      # Grabs the matching string, packs it into a hash along with current time,
      # appends the hash to an array, dispatches the array for sending if its
      # size >= $threshold
      def pack(arr, line)
        begin
          arr << { (line.match /#{$string}/)[0] => Time.now.xmlschema }
        rescue RegexpError
          puts "\tError: invalid regular expression."
          puts "\tCheck the $string pattern in the config file."
          exit
        end
        if arr.size >= $threshold
          Watchlog::Sender.post(arr)
          arr.clear
        end
      end

    end
  end
end
