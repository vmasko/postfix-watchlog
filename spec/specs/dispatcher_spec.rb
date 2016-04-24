RSpec.describe Dispatcher do
  describe "#run" do
    before  { allow(Dispatcher).to receive(:parse) { "Called Dispatcher::parse" } }
    let(:call_run) { described_class.run }

    it "opens file" do
      silence do
        call_run
        expect(load_check($load_path)).to eq true
      end
    end

    it "notifies about Ctrl+C after open" do
      expect(STDOUT).to receive(:puts).with(String)
      call_run
    end

    it "calls #parse" do
      silence do
        expect(call_run).to eq "Called Dispatcher::parse"
      end
    end

    # it "rescues Errno::ENOENT" do
    # end
  end

  describe "#parse" do
    it "tails the file" do
    end

    it "calls #pack if line match pattern" do
    end

    it "rescues RegexpError" do
      # $line = "***=?"
      # File.open($load_path) do |log|
      # expect(described_class.parse(f)).to raise_error(RegexpError)
      # f.close
    end
  end

  describe "#pack" do
    subject { described_class.pack([], "to=<test@email.com>") }

    it "packs matched string into hash and appends it to array" do

    end

    it "calls #post" do
    end

    it "clears array if its size > threshold" do
    end

    it "rescues RegexpError" do
    end
  end
end
