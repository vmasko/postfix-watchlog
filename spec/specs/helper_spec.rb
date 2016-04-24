RSpec.describe Helper do

  describe "::text" do
    let(:string)    { "\tService has started." }
    let(:call_text) { described_class::text(:start) }

    it "puts appropriate text" do
      expect(STDOUT).to receive(:puts).with(string)
      call_text
    end
  end
end
