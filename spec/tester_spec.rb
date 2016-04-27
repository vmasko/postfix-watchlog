RSpec.describe Watchlog::Tester do
  let(:tester)   { Tester.new }
  let(:hash)       { { a: 123 } }
  let(:build_data) { 3.times { tester.process(hash) } }

  context '#process' do
    it 'добавляет хеш в data' do
      tester.process(hash)
      expect(tester.data).to eq [{ a: 123 }]
    end
  end

  context '#write' do
    let(:contents) { File.open(Tester::PATH, 'r').read }
    let(:cleanup)  { File.delete(Tester::PATH) }
    let(:mute)     { allow(STDOUT).to receive(:puts) }

    it 'пишет data в файл с переносами строк между хешами' do
      mute
      build_data
      tester.write
      expect(contents).to eq "{:a=>123}\n{:a=>123}\n{:a=>123}\n"
      cleanup
    end
  end

  context '#stats' do
    let(:hash)  { { status: 'Connection refused' } }
    let(:stats) { tester.stats }
    it 'выводит количество статусов по убыванию' do
      build_data
      tester.process(status: 'Connection timed out')
      expect { stats }.to output("Connection refused: 3\nConnection timed out: 1\n").to_stdout
    end
  end
end
