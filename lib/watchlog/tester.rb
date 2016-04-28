module Watchlog
  class Tester
    PATH  = ARGV[2] || 'bin/output.log'
    attr_accessor :data, :counter

    def initialize
      @data = []
      @counter = Hash.new(0)
    end

    def process(hash)
      data << hash
      @counter[hash[:type]] += 1
    end

    def write
      File.open(PATH, 'w') do |f|
        f.puts data.map(&:to_s).join("\n")
      end
      stats
    end

    def stats
      counter.sort_by(&:last).reverse.each do |arr|
        puts "#{arr[0]}: #{arr[1]}\n"
      end
    end
  end
end
