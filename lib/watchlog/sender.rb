module Watchlog
  class Sender
    LIMIT   = 10
    ADDRESS = 'http://localhost:9000'
    HTTP_ERRORS = [
                    EOFError,
                    Errno::ECONNRESET,
                    Errno::EINVAL,
                    Errno::ECONNREFUSED
                  ]
    attr_accessor :data

    def initialize
      @data = []
    end

    def process(hash)
      @data << hash
      deliver if should_deliver?
    end

    def should_deliver?
      data.size >= LIMIT
    end

    def payload
      { errors: data.first(LIMIT) }.to_json
    end

    def notify
      uri = URI(ADDRESS)
      req = Net::HTTP::Post.new(uri, initheader = { 'Content-Type' => 'application/json' })
      req.body = payload
      Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }
    end

    def deliver
      cleanup if notify
    end

    def cleanup
      @data.shift(LIMIT)
    end
  end
end
