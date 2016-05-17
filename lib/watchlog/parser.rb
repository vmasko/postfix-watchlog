require 'time'

module Watchlog
  class Parser
    STATUS_BOUNCED = /status=bounced|status=deferred/
    SMTP_ERROR     = /Relay access denied/
    YANDEX_LIMIT   = /<everyday@e-xecutive.ru> has exceeded|honest-mailers/
    EMAIL_TO       = /(?<=to=<)(.*?)(?=>)/
    HOST           = /(?<=connect\sto\s)(.*?)(?=:)|(?<=name=)(.*?)(?=\s)|(?<=host\s)(.*?)(?=\ssaid)/
    MESSAGE        = /(?<=\()(.*?)(?=\)$)/
    TYPE           = /(?<=said:)(.*?)(?=\s\()/
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
      TYPES.each { |m, t| return t if line.match(m) }
      return 'Add new type for this message: ' + line.match(MESSAGE).to_s
    end
  end
end
