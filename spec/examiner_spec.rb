RSpec.describe Watchlog::Examiner do
  let(:examiner) { Examiner.new }
  let(:hash)     { {a: 123} }

  context '#process' do
    it 'добавляет хеш в data' do
      examiner.process(hash)
      expect(examiner.data).to eq [{ a: 123 }]
    end
  end

  context '#write' do
    let(:contents) { File.open(Examiner::PATH, 'r').read }
    let(:cleanup)  { File.delete(Examiner::PATH) }

    it 'пишет data в файл' do
      examiner.process(hash)
      examiner.write
      expect(contents).to eq "{:errors=>[{:a=>123}]}\n"
      cleanup
    end
  end


end
