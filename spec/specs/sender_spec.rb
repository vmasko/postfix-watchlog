RSpec.describe Sender do

  describe "::post" do
    let(:arr)       { [{ "email": "time" }, { "email": "time" }] }
    let(:body)      { "{\"bounced\":[{\"email\":\"time\"},{\"email\":\"time\"}]}" }
    let(:call_post) { described_class::post(arr) }

    it "packs array into a hash, converts hash to a JSON,
        sends JSON with a POST request and notifies about its status" do
      stub_request(:post, $address).with(body: body).to_return(status: 200, body: "", headers: {})
      expect(STDOUT).to receive(:puts).with(String)
      expect(call_post).to be_nil
    end

    # it "rescues Errno::ECONNREFUSED" do
    # end
  end
end
