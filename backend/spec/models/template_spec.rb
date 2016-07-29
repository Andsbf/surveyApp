RSpec.describe Template, type: :model do
  it { is_expected.to validate_presence_of(:slug) }
  it { is_expected.to validate_uniqueness_of(:slug) }
  it { is_expected.to validate_presence_of(:priority) }

  let(:merchant) { Fabricate(:merchant) }
  let(:template) { Fabricate(:template) }

  describe 'generate' do
    let(:params) {{
      name: 'Jimanda',
      social_campaign_id: 123,
      internal_email_id: 456,
      internal_email_name: 'Jimothy',
      hot_leads_list: 'Jimmica'
    }}

    before :each do
      @rule = template.generate(merchant, params)
    end

    it 'has the correct name' do
      expect(@rule.name).to eq('Jimanda')
    end

    it 'has the correct rule attributes' do
      expect(@rule.recheck_satisfaction).to eq(true)
    end

    it 'has the correct requirement values' do
      expect(@rule.requirements.first.value).to eq(123)
    end

    it 'has the correct email action values' do
      expect(@rule.actions.where(type: 'send-internal-email').first.arguments).to eq({
        'wishmail' => 456, 'name' => 'Jimothy', 'type' => 'send'
      })
    end

    it 'has the correct list action values' do
      expect(@rule.actions.where(type: 'add-remove-list').first.arguments).to eq({
        'list_id' => List.last.id.to_s, 'name' => 'Jimmica', 'action' => 'add'
      })
    end
  end
end
