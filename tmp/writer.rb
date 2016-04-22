require 'file-tail'
include File::Tail

File.open("log.log") do |log|
  log.backward(1)
  out = File.new("out.out", "w")
  log.tail do |line|
    out.write line if line.match /shit/
  end
  out.close
end
