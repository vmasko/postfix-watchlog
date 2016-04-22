module Bounce

  class Sender

    def pack(f, type)
      type = type.to_sym
      hash = { type => {} }
      file = File.open(f, "r")
      file.each_line.with_index do |line, i|
        hash[type][i.to_s] = { email: line, time: Time.now.xmlschema }
      end
      send(hash.to_json)
    end

    def send(hash)
      uri = URI('https://myapp.com/api/v1/resource')
      request = Net::HTTP::Post.new(uri, initheader = {'Content-Type' =>'application/json'})
      request.body = hash
      resp = http.request(request)
      puts resp
    end
  end
end
