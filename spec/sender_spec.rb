RSpec.describe Watchlog::Sender do
  let(:sender)      { Sender.new }
  let(:hash)        { { a: 123 } }
  let(:pass_limit)  { Sender::LIMIT.times { sender.process(hash) } }
  let(:stub)        { stub_request(:any, Sender::ADDRESS) }

  context '#should_deliver?' do
    it 'возвращает true, если размер data >= LIMIT' do
      allow(sender).to receive(:deliver)
      pass_limit
      expect(sender.should_deliver?).to eq true
    end

    it 'возвращает false, если размер data < LIMIT' do
      expect(sender.should_deliver?).to eq false
    end
  end

  context '#process' do
    it 'добавляет хеш в data' do
      sender.process(hash)
      expect(sender.data).to include(hash)
    end

    it 'вызывается LIMIT раз' do
      stub
      pass_limit
      expect(sender.data).to eq []
    end
  end

  context '#payload' do
    it 'возвращает JSON-строку с data внутри' do
      sender.process(hash)
      expect(sender.payload).to eq "{\"errors\":[{\"a\":123}]}"
    end
  end

  context '#notify' do
    it 'отправляет payload в POST-запросе' do
      stub_request(:post, Sender::ADDRESS).
        with({ :body => "{\"errors\":[]}", :headers => { 'Content-Type'=>'application/json' } })
      expect(sender.notify).to be_a Net::HTTPOK
    end
  end
end
