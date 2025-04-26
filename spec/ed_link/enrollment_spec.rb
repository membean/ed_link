# frozen_string_literal: true

RSpec.describe EdLink::Enrollment do
  let(:method) { :get }

  before do
    expect(EdLink::Enrollment).to receive(:request).with(method: method, path: path, params: params)
  end

  describe '#all' do
    let(:path) { '/enrollments' }

    context 'with no params' do
      let(:params) { {} }
    
      it 'calls the correct API endpoint' do
        EdLink::Enrollment.all
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'role, person_id, state' }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Enrollment.all(params: params)
      end
    end
  end

  describe '#find' do
    let(:path) { "/enrollments/#{id}" }
    let(:id) { 123456 }

    context 'with no params' do
      let(:params) { {} }
    
      it 'calls the correct API endpoint' do
        EdLink::Enrollment.find(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'role, person_id, state' }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Enrollment.find(id: id, params: params)
      end
    end
  end
end