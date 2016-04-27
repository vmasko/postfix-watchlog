module Watchlog
  class Tester
    PATH  = ARGV[2] || 'bin/output.log'
    attr_accessor :data

    def initialize
      @data = []
    end

    def process(hash)
      data << hash
    end

    def write
      File.open(PATH, 'w') do |f|
        f.puts data.map(&:to_s).join("\n")
      end
    end
  end
end
