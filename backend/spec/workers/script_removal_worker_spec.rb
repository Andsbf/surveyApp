RSpec.describe ScriptRemovalWorker do
  let(:merchant) { Fabricate(:merchant) }
  let(:lead) { Fabricate(:lead, mid: merchant.id, scripts: [{ action: 123, count: 0 }]) }

  describe 'perform' do
    it 'fires a job' do
      lead
      args = [merchant.id, 123]
      described_class.new.perform(*args)

      expect(Sentry::TrackAttributeWorker.jobs.size).to eq(1)
    end
  end
end
