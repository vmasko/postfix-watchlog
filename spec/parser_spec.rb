RSpec.describe Watchlog::Parser do
  let(:bounced) { Parser.new('Aug 15 15:20:06bstatus=bounced to host1[1]: to=<email1> (message1: status1)') }
  let(:smtp)    { Parser.new('Aug 16 15:20:06 Relay access denied to host2[2]: to=<email2> (message2: status2)') }
  let(:nothing) { Parser.new('irrelevant string') }

  context '#bounced?' do
    it 'возвращает true, если строка соответствует STATUS_BOUNCED' do
      expect(bounced.bounced?).to eq true
    end

    it 'возвращает true, если строка соответствует SMTP_ERROR' do
      expect(smtp.bounced?).to eq true
    end

    it 'возвращает false, если соответствий нет' do
      expect(nothing.bounced?).to eq false
    end
  end

  context '#data' do
    let(:bounced_data) do
      {
        email:     'email1',
        host:      'host1[1]',
        message:   'message1: status1',
        status:    'status1',
        timestamp: bounced.timestamp
      }
    end
    let(:smtp_data) do
      {
        email:     'email2',
        host:      'host2[2]',
        message:   'message2: status2',
        status:    'status2',
        timestamp: smtp.timestamp
      }
    end

    it 'возвращает хеш с data внутри' do
      expect(bounced.data).to eq bounced_data
      expect(smtp.data).to eq smtp_data
    end
  end
end
