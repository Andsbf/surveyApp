RSpec.describe VisitorFilter do
  let(:merchant) { Fabricate(:merchant) }
  let(:service) { described_class.new(params, merchant) }

  describe 'no params' do
    before :each do
      @visitor = Fabricate(:visitor, mid: merchant.id)
    end

    context 'with a match' do
      let(:params) { {} }

      it 'finds the visitor' do
        expect(service.filter).to include(@visitor)
      end
    end
  end

  describe 'cid' do
    let(:array_params) { {} }

    before :each do
      @visitor = Fabricate(:visitor, cid: 'abc123', merchant: merchant)
    end

    context 'without a match' do
      let(:params) { { cid: '123' } }

      it 'does not find the visitor' do
        expect(service.filter).to_not include(@visitor)
      end
    end

    context 'with invalid chars in search' do
      let(:params) { { cid: '$ab.c123' } }

      it 'strips the chars and finds the visitor' do
        expect(service.filter).to include(@visitor)
      end
    end

    context 'when regex special chars in search' do
      let(:visitor) { Fabricate(:visitor, cid: 'abc+123', merchant: merchant) }
      let(:params) { { cid: 'abc+123' } }

      it 'strips the chars and finds the visitor' do
        expect(service.filter).to include(visitor)
      end
    end
  end

  describe 'participated' do
    before :each do
      @visitor = Fabricate(:visitor, participated: [123456], mid: merchant.id)
    end

    context 'without a match' do
      let(:params) { { participated: '123' } }

      it 'does not find the visitor' do
        expect(service.filter).to_not include(@visitor)
      end
    end

    context 'with a match' do
      let(:params) { { participated: '123456' } }

      it 'finds the visitor' do
        expect(service.filter).to include(@visitor)
      end
    end
  end

  describe 'cid_search' do
    before :each do
      @visitor = Fabricate(:visitor, cid: 'abc123', mid: merchant.id)
    end

    context 'with a match' do
      let(:params) { { cid_search: 'abc' } }

      it 'finds the visitor' do
        expect(service.filter).to include(@visitor)
      end
    end

    context 'without a match' do
      let(:params) { { cid_search: '123' } }

      it 'does not find the visitor' do
        expect(service.filter).to_not include(@visitor)
      end
    end

    context 'with invalid chars in search' do
      let(:params) { { cid_search: '$ab.c' } }

      it 'strips the chars and finds the visitor' do
        expect(service.filter).to include(@visitor)
      end
    end

    context 'when regex special chars in search' do
      let(:visitor) { Fabricate(:visitor, cid: 'abc+123', mid: merchant.id) }
      let(:params) { { cid_search: 'abc+123' } }

      it 'strips the chars and finds the visitor' do
        expect(service.filter).to include(visitor)
      end
    end
  end

  describe 'workflow' do
    before :each do
      @visitor = Fabricate(:visitor, workflows: ['abc123'], mid: merchant.id)
    end

    context 'without a match' do
      let(:params) { { workflow: '123' } }

      it 'does not find the visitor' do
        expect(service.filter).to_not include(@visitor)
      end
    end

    context 'with a match' do
      let(:params) { { workflow: 'abc123' } }

      it 'strips the chars and finds the visitor' do
        expect(service.filter).to include(@visitor)
      end
    end
  end
end
