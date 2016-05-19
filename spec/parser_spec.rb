RSpec.describe Watchlog::Parser do
  let(:bounced) { Parser.new('Aug 15 15:20:06 status=bounced connect to host1[1]: to=<email1> (msg: connection refused)') }
  let(:smtp)    { Parser.new('Aug 16 15:20:06 Relay access denied connect to host2[2]: to=<email2> (msg: relay access denied)') }
  let(:nothing) { Parser.new('irrelevant string') }

  context '#bounced?' do
    it 'returns true if line matches STATUS_BOUNCED' do
      expect(bounced.bounced?).to eq true
    end

    it 'returns true if line matches SMTP_ERROR' do
      expect(smtp.bounced?).to eq true
    end

    it 'returns false if line matches nothing' do
      expect(nothing.bounced?).to eq false
    end
  end

  context '#data' do
    let(:bounced_data) do
      {
        email:     'email1',
        host:      'host1[1]',
        message:   'msg: connection refused',
        type:      'Connection error',
        timestamp: bounced.timestamp
      }
    end
    let(:smtp_data) do
      {
        email:     'email2',
        host:      'host2[2]',
        message:   'msg: relay access denied',
        type:      'Relaying denied',
        timestamp: smtp.timestamp
      }
    end

    it 'returns a hash containing data' do
      expect(bounced.data).to eq bounced_data
      expect(smtp.data).to eq smtp_data
    end
  end

  context '#type' do
    let(:known_error)   { Parser.new('(the message considered as spam)')}
    let(:unknown_error) { Parser.new('(unknown error)') }

    it 'returns clean error type' do
      expect(known_error.type).to eq 'Spam suspicion'
    end

    it 'returns prompt to add type for an unknown message' do
      expect(unknown_error.type).to eq 'Add new type for this message: unknown error'
    end
  end
end
