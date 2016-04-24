module Watchlog

  class Helper
    class << self

      def text(type)
        list = {
          start:      "\tService has started.",
          interrupt:  "\tService stopped.",
          stop:       "\tPress Ctrl-C to stop the service.",
          enoent:     "\tError: file not found. Check the $load_path in the config file.",
          regexp_ln:  "\tError: invalid regular expression.\n\tCheck the $line pattern in the config file.",
          regexp_str: "\tError: invalid regular expression.\n\tCheck the $string pattern in the config file.",
          retry:      "\tError: connection refused.\n\tRetrying...",
          fail:       "\tFailed to connect.\n\tCheck the server status or $address in the config file."
        }
        puts list[type]
      end

    end
  end
end
