require 'time'
require 'json'
require 'net/http'
require 'file-tail'
include File::Tail
require_relative 'watchlog/cli'
require_relative 'watchlog/dispatcher'
require_relative 'watchlog/sender'
