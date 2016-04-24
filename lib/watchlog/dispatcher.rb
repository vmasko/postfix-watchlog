module Watchlog

  class Dispatcher
    class << self

      # Opens the file, passes it to the #parse
      def run
        begin
          File.open($log_path) do |log|
            Helper::text(:stop)
            Dispatcher::parse(log)
          end
        rescue Errno::ENOENT
          Helper::text(:enoent)
          exit
        end
      end

      # Tails the file, grabs matching lines and passes them to the #pack
      def parse(log)
        arr = []
        begin
          log.tail do |line|
            Dispatcher::pack(arr, line) if line.match /#{$line}/
          end
        rescue RegexpError
            Helper::text(:regexp_l)
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
          Helper::text(:regexp_s)
          exit
        end
        if arr.size >= $threshold
          Sender::post(arr)
          arr.clear
        end
      end

    end
  end
end
