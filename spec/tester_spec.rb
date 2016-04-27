RSpec.describe Watchlog::Tester do
  let(:examiner)   { Tester.new }
  let(:hash)       { {a: 123} }
  let(:build_data) { 3.times { examiner.process(hash) } }

  context '#process' do
    it 'добавляет хеш в data' do
      examiner.process(hash)
      expect(examiner.data).to eq [{ a: 123 }]
    end
  end

  context '#write' do
    let(:contents) { File.open(Tester::PATH, 'r').read }
    let(:cleanup)  { File.delete(Tester::PATH) }

    it 'пишет data в файл с переносами строк между хешами' do
      build_data
      examiner.write
      expect(contents).to eq "{:a=>123}\n{:a=>123}\n{:a=>123}\n"
      cleanup
    end
  end


end
