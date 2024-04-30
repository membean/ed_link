# frozen_string_literal: true

RSpec.describe EdLink::People do
  let(:method) { :get }

  describe '#agents' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/agents" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::People.agents(id: id)
      end
    end

    context 'when filtering' do
      let(:filter) do
        {
            relationship: [
              {
                operator: 'equals',
                value: 'parent'
              }
            ]
          }
      end
      
      it 'calls the API endpoint with the proper params' do
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::People.agents(id: id, filter: filter)
      end
    end
  end
  
  describe '#all' do
    let(:path) { '/people' }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::People.all
      end
    end

    context 'when filtering' do
      let(:filter) do
        {
            first_name: [
              {
                operator: 'starts with',
                value: 'z'
              }
            ]
          }
      end
      
      it 'calls the API endpoint with the proper params' do
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::People.all(filter: filter)
      end
    end
  end

  describe '#classes' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/classes" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::People.classes(id: id)
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
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::People.classes(id: id, filter: filter)
      end
    end
  end

  describe '#districts' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/districts" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::People.districts(id: id)
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
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::People.districts(id: id, filter: filter)
      end
    end
  end

  describe '#enrollments' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/enrollments" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::People.enrollments(id: id)
      end
    end

    context 'when filtering' do
      let(:filter) do
        {
            role: [
              {
                operator: 'equals',
                value: 'teacher'
              }
            ]
          }
      end
      
      it 'calls the API endpoint with the proper params' do
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::People.enrollments(id: id, filter: filter)
      end
    end
  end

  describe '#find' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}" }

    it 'calls the correct API endpoint' do
      expect(EdLink::People).to receive(:request).with(method: method, path: path)
      EdLink::People.find(id: id)
    end
  end

  describe '#schools' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/schools" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::People.schools(id: id)
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
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::People.schools(id: id, filter: filter)
      end
    end
  end

  describe '#sections' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/sections" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::People.sections(id: id)
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
        expect(EdLink::People).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::People.sections(id: id, filter: filter)
      end
    end
  end
end