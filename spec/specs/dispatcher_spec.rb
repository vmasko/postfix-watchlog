RSpec.describe Dispatcher do

  describe "::run" do
    let(:call_run) { described_class::run }

    before { allow(Dispatcher).to receive(:parse).with(File) { "Called Dispatcher::parse" } }

    it "opens file" do
      silence do
        call_run
        expect(check_load($load_path)).to eq true
      end
    end

    it "notifies about open" do
      expect(STDOUT).to receive(:puts).with(String)
      call_run
    end

    it "calls ::parse and passes a file to it" do
      silence do
        expect(call_run).to eq "Called Dispatcher::parse"
      end
    end

    # it "rescues Errno::ENOENT" do
    # end
  end

  describe "::parse" do
    let(:call_parse) { described_class::parse(File) }

    before { allow(File).to receive(:tail) { "Called File::tail" } }

    it "tails the file" do
      expect(call_parse).to eq "Called File::tail"
    end

    # it "calls ::pack if line match pattern" do
    # end

    # it "rescues RegexpError" do
    # end
  end

  describe "::pack" do
    let(:string)    { " to=<test@example.com> " }
    let(:pack_post) { described_class::pack([1] * ($threshold - 1), string) }
    let(:pack_wait) { described_class::pack([1] * ($threshold - 2), string) }

    before { allow(Sender).to receive(:post).with(Array) }

    it "calls ::post and clears array if its size >= threshold" do
      expect(pack_post).to eq []
    end

    it "does nothing if array size < threshold" do
      expect(pack_wait).to be_nil
    end

    # it "rescues RegexpError" do
    # end
  end
end
