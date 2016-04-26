module Watchlog
  class Sender
    LIMIT   = 10
    RETRIES = 10
    BEFORE_RETRY = 15
    BEFORE_PUSH  = 300
    ADDRESS = ENV['POSTFIX_API_ENDPOINT'] || 'http://localhost:9000'
    HTTP_ERRORS = [
                    Errno::ECONNRESET,
                    Errno::EINVAL,
                    Errno::ECONNREFUSED,
                    Timeout::Error
                  ]
    attr_accessor :data

    def initialize
      @data = []
      start_catalyst
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
      r ||= RETRIES
      cleanup(LIMIT) if notify
    rescue *HTTP_ERRORS => message
      if (r -= 1) > 0
        puts "#{message}\nRetrying..."
        sleep BEFORE_RETRY
        retry
      end
      exit
    end

    def start_catalyst
      s = Mutex.new
      Thread.new { loop { s.synchronize { push } } }
    end

    def push
      if data.size > 0
        notify
        cleanup(data.size)
      end
      sleep BEFORE_PUSH
    end

    def cleanup(amount)
      @data.shift(amount)
    end
  end
end
