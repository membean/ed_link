# frozen_string_literal: true

RSpec.describe EdLink::Course do
  let(:method) { :get }

  describe '#all' do
    let(:path) { '/courses' }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::Course).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::Course.all
      end
    end

    context 'when filtering' do
      let(:filter) do
        {
            name: [
              {
                operator: 'starts with',
                value: 'z'
              }
            ]
          }
      end
      
      it 'calls the API endpoint with the proper params' do
        expect(EdLink::Course).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::Course.all(filter: filter)
      end
    end
  end

  describe '#classes' do
    let(:id) { 123456 }
    let(:path) { "/courses/#{id}/classes" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::Course).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::Course.classes(id: id)
      end
    end

    context 'when filtering' do
      let(:filter) do
        {
            name: [
              {
                equals: 'starts with',
                value: 'z'
              }
            ]
          }
      end
      
      it 'calls the API endpoint with the proper params' do
        expect(EdLink::Course).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::Course.classes(id: id, filter: filter)
      end
    end
  end

  describe '#find' do
    let(:id) { 123456 }
    let(:path) { "/courses/#{id}" }

    it 'calls the correct API endpoint' do
      expect(EdLink::Course).to receive(:request).with(method: method, path: path)
      EdLink::Course.find(id: id)
    end
  end
end