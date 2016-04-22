module Bounce

  class Keeper
    class << self

      def run(path)
        File.open(path) do |log|
          log.backward(10)
          extract(log)
        end
      end

      def extract(log)
        log.tail do |line|
          if line.match /#{$line_selector}/
            store(line.match /#{$string_selector}/)
          end
        end
      end

      def store(line)
        out = File.new("#{ROOT}/tmp/queue.out", "a")
        out.puts line
        out.close
      end

    end
  end
end
