module BounceKeeper

  class Keeper
    class << self

      def load(path)
        File.open(path) do |log|
          log.extend(File::Tail)
          log.backward(1)
          log.tail do |line|
            puts line if line.match /status=deferred|status=bounce/
          end
        end
      end

    end
  end
end
