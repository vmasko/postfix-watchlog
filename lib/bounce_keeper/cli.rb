module BounceKeeper

  class CLI
    class << self

      def start
        puts "Hi! Log tracking has started."
        BounceKeeper::Keeper.load("../test/example.log")
      end

    end
  end
end
