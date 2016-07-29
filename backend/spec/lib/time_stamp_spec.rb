RSpec.describe TimeStamp do
  let(:hour_stamp) { TimeStamp.new('hour', DateTime.new(2015, 2, 3, 12))}
  let(:day_stamp) { TimeStamp.new('day', DateTime.new(2015, 2, 3, 12))}
  let(:month_stamp) { TimeStamp.new('month', DateTime.new(2015, 2, 3, 12))}

  describe 'generate' do
    it 'should return a properly formatted hour stamp' do
      expect(hour_stamp.generate).to eq('2015-02-03 12:00')
    end

    it 'should return a properly formatted day stamp' do
      expect(day_stamp.generate).to eq('2015-02-03')
    end

    it 'should return a properly formatted month stamp' do
      expect(month_stamp.generate).to eq('2015-02')
    end
  end
end
