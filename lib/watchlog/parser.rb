module Watchlog
  class Parser
    STATUS_BOUNCED = /status=bounced|status=deferred/
    SMTP_ERROR     = /Relay access denied/
    MESSAGE        = /(?<=\()(.*?)(?=\))/
    EMAIL_TO       = /(?<=to=<)(.*?)(?=>)/
    attr_accessor :line

    def initialize(line)
      @line = line
    end

    def data
      {
        email:     line.match(EMAIL_TO).to_s,
        message:   line.match(MESSAGE).to_s,
        timestamp: Time.now.xmlschema
       }
    end

    def bounced?
      return true if line.match STATUS_BOUNCED
      return true if line.match SMTP_ERROR
      false
    end
  end
end
