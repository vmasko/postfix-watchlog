RSpec.describe CLI do

  describe "::start" do
    let(:call_start) { described_class::start }

    before { allow(Dispatcher).to receive(:run) { "Called Dispatcher::run" } }
    
    it "notifies about start" do
      expect(STDOUT).to receive(:puts).with(String)
      call_start
    end

    it "calls Dispatcher::run" do
      silence do
        expect(call_start).to eq "Called Dispatcher::run"
      end
    end

    # it "rescues Interrupt" do
    # end
  end
end
