RSpec.describe Watchlog::Parser do
  let(:bounced) { Parser.new('status=bounced to=<email1> (message1)') }
  let(:smtp)    { Parser.new('status=bounced to=<email2> (message2)') }
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
    let(:bounced_data) { { :email=>"email1", :message=>"message1", :timestamp=>Time.now.xmlschema } }
    let(:smtp_data)    { { :email=>"email2", :message=>"message2", :timestamp=>Time.now.xmlschema } }

    it 'возвращает хеш с data внутри' do
      expect(bounced.data).to eq bounced_data
      expect(smtp.data).to eq smtp_data
    end
  end
end
