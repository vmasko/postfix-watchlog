require 'time'
require 'json'
require 'net/http'
require 'file-tail'
include File::Tail
require_relative 'bounce_keeper/cli'
require_relative 'bounce_keeper/keeper'
require_relative 'bounce_keeper/sender'
