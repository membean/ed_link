# frozen_string_literal: true

RSpec.describe EdLink::Course do
  let(:method) { :get }

  before do
    expect(EdLink::Course).to receive(:request).with(method: method, path: path, params: params)
  end

  describe '#all' do
    let(:path) { '/courses' }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Course.all
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
        EdLink::Course.all(params: params)
      end
    end
  end

  describe '#classes' do
    let(:id) { 123456 }
    let(:path) { "/courses/#{id}/classes" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Course.classes(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'name, id',
          filter: {
            name: [
              {
                equals: 'starts with',
                value: 'z'
              }
            ]
          }
        }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Course.classes(id: id, params: params)
      end
    end
  end

  describe '#find' do
    let(:id) { 123456 }
    let(:path) { "/courses/#{id}" }

    context 'with no params' do
      let(:params) { {} }
    
      it 'calls the correct API endpoint' do
        EdLink::Course.find(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'name, code' }
      end

      it 'calls the correct API endpoint' do
        EdLink::Course.find(id: id, params: params)
      end
    end
  end
end