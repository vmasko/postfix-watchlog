module Loader

  def load(path)
    File.open(path) do |log|
      log.extend(File::Tail)
      log.backward(1)
      log.tail { |line| puts line }
    end
  end
end
