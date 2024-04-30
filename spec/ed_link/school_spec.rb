# frozen_string_literal: true

RSpec.describe EdLink::School do
  let(:method) { :get }

  describe '#administrators' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/administrators" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::School.administrators(id: id)
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
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::School.administrators(id: id, filter: filter)
      end
    end
  end

  describe '#all' do
    let(:path) { '/schools' }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::School.all
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
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::School.all(filter: filter)
      end
    end
  end

  describe '#classes' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/classes" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::School.classes(id: id)
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
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::School.classes(id: id, filter: filter)
      end
    end
  end

  describe '#courses' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/courses" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::School.courses(id: id)
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
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::School.courses(id: id, filter: filter)
      end
    end
  end

  describe '#find' do
    subject { EdLink::School.find(id: id) }
    
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}" }

    it 'calls the correct API endpoint' do
      expect(EdLink::School).to receive(:request).with(method: method, path: path)
      subject
    end
  end

  describe '#people' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/people" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::School.people(id: id)
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
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::School.people(id: id, filter: filter)
      end
    end
  end

  describe '#sessions' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/sessions" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::School.sessions(id: id)
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
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::School.sessions(id: id, filter: filter)
      end
    end
  end

  describe '#students' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/students" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::School.students(id: id)
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
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::School.students(id: id, filter: filter)
      end
    end
  end

  describe '#teachers' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/teachers" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::School.teachers(id: id)
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
        expect(EdLink::School).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::School.teachers(id: id, filter: filter)
      end
    end
  end
end