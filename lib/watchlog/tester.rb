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
      @counter[hash[:status]] += 1
    end

    def write
      File.open(PATH, 'w') do |f|
        f.puts data.map(&:to_s).join("\n")
      end
      counter.each { |key, value| puts "#{key}: #{value}\n"}
    end
  end
end
