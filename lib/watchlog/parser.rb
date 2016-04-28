module Watchlog
  class Parser
    STATUS_BOUNCED = /status=bounced|status=deferred/
    SMTP_ERROR     = /Relay access denied/
    YANDEX_LIMIT   = /<everyday@e-xecutive.ru> has exceeded|honest-mailers/
    EMAIL_TO       = /(?<=to=<)(.*?)(?=>)/
    HOST           = /(?<=to\s)(.*?)(?=:)/
    MESSAGE        = /(?<=\()(.*?)(?=\))/
    TIMESTAMP      = /^.*:\d{2}(?=\s\w)/
    attr_accessor :line

    def initialize(line)
      @line = line
    end

    def data
      {
        email:     line.match(EMAIL_TO).to_s,
        host:      line.match(HOST).to_s,
        message:   line.match(MESSAGE).to_s,
        type:      type,
        timestamp: timestamp
       }
    end

    def bounced?
      return false if line.match YANDEX_LIMIT
      return true  if line.match STATUS_BOUNCED
      return true  if line.match SMTP_ERROR
      false
    end

    def timestamp
      Time.parse(line.match(TIMESTAMP).to_s).xmlschema
    end

    def type
      if check_message('Connection')
        'Connection error'
      elsif check_message('over quota')
        'Account is over quota'
      elsif check_message('block list')
        'Messages weren\'t sent'
      elsif check_message('account is full')
        'Account is full'
      elsif check_message('currently unavailable')
        'Service is currently unavailable'
      elsif check_message('Host not found')
        'Host not found'
      end
    end

    def check_message(word)
      line.match(MESSAGE).to_s.include?(word)
    end
  end
end
