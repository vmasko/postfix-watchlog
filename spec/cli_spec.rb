RSpec.describe CLI do

  describe "#start" do
    before  { allow(Dispatcher).to receive(:run) { "Called Dispatcher#run" } }
    subject { described_class.start }

    it "notifies about start" do
      expect(STDOUT).to receive(:puts).with(String)
      subject
    end

    it "calls #run" do
      silence do
        expect(subject).to eq "Called Dispatcher#run"
      end
    end

    # it "rescues Interrupt" do
    # end
  end
end
