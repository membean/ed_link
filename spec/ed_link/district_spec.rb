# frozen_string_literal: true

RSpec.describe EdLink::District do
  let(:method) { :get }

  before do
    expect(EdLink::District).to receive(:request).with(method: method, path: path, params: params)
  end

  describe '#administrators' do
    let(:path) { "/districts/#{id}/administrators" }
    let(:id) { 123456 }

    context 'with no params' do
      let(:params) { {} }
    
      it 'calls the correct API endpoint' do
        EdLink::District.administrators(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'first_name, last_name' }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::District.administrators(id: id, params: params)
      end
    end
  end

  describe '#all' do
    let(:path) { '/districts' }

    context 'with no params' do
      let(:params) { {} }
    
      it 'calls the correct API endpoint' do
        EdLink::District.all
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'name, time_zone' }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::District.all(params: params)
      end
    end
  end

  describe '#find' do
    let(:path) { "/districts/#{id}" }
    let(:id) { 123456 }

    context 'with no params' do
      let(:params) { {} }
    
      it 'calls the correct API endpoint' do
        EdLink::District.find(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'name, time_zone' }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::District.find(id: id, params: params)
      end
    end
  end
end