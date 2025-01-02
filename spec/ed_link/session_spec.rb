# frozen_string_literal: true

RSpec.describe EdLink::Session do
  let(:method) { :get }

  before do
    expect(EdLink::Session).to receive(:request).with(method: method, path: path, params: params)
  end

  describe '#all' do
    let(:path) { '/sessions' }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Session.all
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'name, code',
          filter: {
            name: [
              {
                operator: 'starts with',
                value: 'z'
              }
            ]
          }
        }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Session.all(params: params)
      end
    end
  end

  describe '#find' do
    let(:id) { 123456 }
    let(:path) { "/sessions/#{id}" }

    context 'with no params' do
      let(:params) { {} }
    
      it 'calls the correct API endpoint' do
        EdLink::Session.find(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'name, code' }
      end

      it 'calls the correct API endpoint' do
        EdLink::Session.find(id: id, params: params)
      end
    end
  end
end