RSpec.describe ActionSerializer do
  let(:rule) { Fabricate(:rule) }
  let(:action) { Fabricate(:action, owner: rule) }
  let(:json) { JSON.parse described_class.new(action).to_json }

  it 'has one key' do
    expect(json.keys.length).to eq(1)
  end

  it 'has the correct key' do
    expect(json.keys.first).to eq('action')
  end

  it 'has the correct nested keys' do
    expect(json['action'].keys).to match(
      %w(id type arguments delay publishable position
      status owner_id owner_type scheduled_time time_window)
    )
  end
end
