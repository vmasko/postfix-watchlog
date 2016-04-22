module Bounce

  class Keeper
    class << self

      # Opens the file, passes it to the parse method
      def run(path)
        begin
          File.open(path) do |log|
            puts "\tLog tracking has started..."
            puts "\tPress Ctrl-C to stop service."
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
        log.backward(10)
        log.tail do |line|
          if line.match /#{$line}/
            store(line.match /#{$string}/)
          end
        end
      end

      # Creates the tmp directory if there's no any,
      # stores the extracted strings, calls sender and then
      # clears the file
      def store(line)
        Dir.mkdir("tmp") unless File.exists?("tmp")
        out = File.new("#{ROOT}/tmp/queue.out", "a")
        out.puts line
        out.close
        Bounce::Sender.send(out, $type)
      end

      # Clears the passed file
      def clear(file)
        File.open(file, "w").close
      end
    end
  end
end
