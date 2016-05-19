RSpec.describe Watchlog::Sender do
  let(:sender)      { Sender.new }
  let(:hash)        { { a: 123 } }
  let(:pass_limit)  { Sender::LIMIT.times { sender.process(hash) } }
  let(:stub)        { stub_request(:any, Sender::ENDPOINT) }

  context '#should_deliver?' do
    it 'returns true if data.size >= LIMIT' do
      allow(sender).to receive(:deliver)
      pass_limit
      expect(sender.should_deliver?).to eq true
    end

    it 'returns false if data.size < LIMIT' do
      expect(sender.should_deliver?).to eq false
    end
  end

  context '#process' do
    it 'appends a hash to data' do
      sender.process(hash)
      expect(sender.data).to include(hash)
    end

    it 'is called LIMIT times' do
      stub
      pass_limit
      expect(sender.data).to eq []
    end
  end

  context '#payload' do
    it 'returns a JSON hash containing data' do
      sender.process(hash)
      expect(sender.payload).to eq "{\"errors\":[{\"a\":123}]}"
    end
  end

  context '#notify' do
    it 'sends payload with a POST request' do
      stub_request(:post, Sender::ENDPOINT).
        with({ :body => "{\"errors\":[]}", :headers => { 'Content-Type'=>'application/json' } })
      expect(sender.notify).to be_a Net::HTTPOK
    end
  end
end
