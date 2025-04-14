# frozen_string_literal: true

RSpec.describe EdLink::Integration do
  let(:method) { :get }

  before do
    expect(EdLink::Integration).to receive(:request).with(method: method, path: path, params: params)
  end

  describe '#all' do
    let(:path) { '/integrations' }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Integration.all
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'status',
          filter: {
            name: [
              {
                operator: 'equals',
                value: 'active'
              }
            ]
          }
        }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Integration.all(params: params)
      end
    end
  end

  describe '#find' do
    let(:id) { 123456 }
    let(:path) { "/integrations/#{id}" }

    context 'with no params' do
      let(:params) { {} }
    
      it 'calls the correct API endpoint' do
        EdLink::Integration.find(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'scope, status' }
      end

      it 'calls the correct API endpoint' do
        EdLink::Integration.find(id: id, params: params)
      end
    end
  end
end
