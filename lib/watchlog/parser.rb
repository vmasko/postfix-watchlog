module Watchlog
  class Parser
    STATUS_BOUNCED = /status=bounced|status=deferred/
    SMTP_ERROR     = /Relay access denied/
    YANDEX_LIMIT   = /<everyday@e-xecutive.ru> has exceeded|honest-mailers/
    EMAIL_TO       = /(?<=to=<)(.*?)(?=>)/
    HOST           = /(?<=to\s)(.*?)(?=:)|(?<=name=)(.*?)(?=\s)/
    MESSAGE        = /(?<=\()(.*?)(?=\))/
    TIMESTAMP      = /^.*:\d{2}(?=\s\w)/
    TYPES = {
      'Connection timed out':             'Connection error',
      'Connection refused':               'Connection error',
      'Host not found, try again':        'Host not found',
      'account is full':                  'Account is full',
      'network is on our block':          'ISP block list',
      'to reach is over quota':           'Account is over quota',
      'service is currently unavailable': 'Service unavailable'
    }
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
      TYPES.each { |m, t| return t if line.match(MESSAGE).to_s.include?(m.to_s) }
    end
  end
end
