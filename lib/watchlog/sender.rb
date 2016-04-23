module Watchlog

  class Sender
    class << self

      # Packs the incoming array into a hash, converts it to a JSON,
      # sends it to the specified address with a POST request
      def post(arr)
        hash = { $type => arr }.to_json
        begin
          uri = URI($address)
          req = Net::HTTP::Post.new(uri, initheader = { 'Content-Type' => 'application/json' })
          req.body = hash
          res = Net::HTTP.start(uri.hostname, uri.port) do |http|
            http.request(req)
          end
          puts "\t#{res}"
        rescue Errno::ECONNREFUSED
          puts "\tError: connection refused."
          puts "\tCheck the server status or $address in the config file."
          exit
        end
      end

    end
  end
end
