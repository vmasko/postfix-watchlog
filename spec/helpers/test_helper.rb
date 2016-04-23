require_relative '../../lib/watchlog'
include Watchlog

# Checks file was loaded
def load_check(path)
  ObjectSpace.each_object(File) do |f|
    unless f.closed? && f.path == path
      return true
    end
  end
end

# Suppresses console output
def silence
  # Store the original stderr and stdout in order to restore them later
  @original_stderr = $stderr
  @original_stdout = $stdout
  # Redirect stderr and stdout
  $stderr = $stdout = StringIO.new
  yield
  $stderr = @original_stderr
  $stdout = @original_stdout
  @original_stderr = nil
  @original_stdout = nil
end

# Reloads test config after before each test
RSpec.configure do |config|
  config.before(:each) do
    load 'config/test_config.rb'
  end
end
