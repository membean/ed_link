# frozen_string_literal: true

RSpec.describe EdLink::Class do
  let(:method) { :get }

  describe '#all' do
    let(:path) { '/classes' }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::Class.all
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
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::Class.all(filter: filter)
      end
    end
  end

  describe '#enrollments' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/enrollments" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::Class.enrollments(id: id)
      end
    end

    context 'when filtering' do
      let(:filter) do
        {
            role: [
              {
                equals: 'starts with',
                value: 'teacher'
              }
            ]
          }
      end
      
      it 'calls the API endpoint with the proper params' do
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::Class.enrollments(id: id, filter: filter)
      end
    end
  end

  describe '#find' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}" }

    it 'calls the correct API endpoint' do
      expect(EdLink::Class).to receive(:request).with(method: method, path: path)
      EdLink::Class.find(id: id)
    end
  end

  describe '#meeting' do
    let(:class_id) { 123456 }
    let(:meeting_id) { 67890 }
    let(:path) { "/classes/#{class_id}/meetings/#{meeting_id}" }

    it 'calls the correct API endpoint' do
      expect(EdLink::Class).to receive(:request).with(method: method, path: path)
      EdLink::Class.meeting(class_id: class_id, meeting_id: meeting_id)
    end
  end

  describe '#meetings' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/meetings" }

    it 'calls the correct API endpoint' do
      expect(EdLink::Class).to receive(:request).with(method: method, path: path)
      EdLink::Class.meetings(id: id)
    end
  end

  describe '#people' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/people" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::Class.people(id: id)
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
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::Class.people(id: id, filter: filter)
      end
    end
  end

  describe '#sections' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/sections" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::Class.sections(id: id)
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
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::Class.sections(id: id, filter: filter)
      end
    end
  end

  describe '#students' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/students" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::Class.students(id: id)
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
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::Class.students(id: id, filter: filter)
      end
    end
  end

  describe '#teachers' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/teachers" }

    context 'when not filtering' do
      let(:filter) { {} }

      it 'calls the correct API endpoint' do
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter:filter)
        EdLink::Class.teachers(id: id)
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
        expect(EdLink::Class).to receive(:request).with(method: method, path: path, filter: filter)
        EdLink::Class.teachers(id: id, filter: filter)
      end
    end
  end
end