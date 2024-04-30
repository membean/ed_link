# frozen_string_literal: true

RSpec.describe EdLink::Class do
  let(:method) { :get }

  before do
    expect(EdLink::Class).to receive(:request).with(method: method, path: path, params: params)
  end

  describe '#all' do
    let(:path) { '/classes' }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Class.all
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'name, id',
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
        EdLink::Class.all(params: params)
      end
    end
  end

  describe '#enrollments' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/enrollments" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Class.enrollments(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'role, primary',
          filter: {
            role: [
              {
                equals: 'equals',
                value: 'teacher'
              }
            ]
          }
        }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Class.enrollments(id: id, params: params)
      end
    end
  end

  describe '#find' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Class.find(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'name, id' }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Class.find(id: id, params: params)
      end
    end
  end

  describe '#meeting' do
    let(:class_id) { 123456 }
    let(:meeting_id) { 67890 }
    let(:path) { "/classes/#{class_id}/meetings/#{meeting_id}" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Class.meeting(class_id: class_id, meeting_id: meeting_id)
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'name, id' }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Class.meeting(class_id: class_id, meeting_id: meeting_id, params: params)
      end
    end
  end

  describe '#meetings' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/meetings" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Class.meetings(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'name, id' }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Class.meetings(id: id, params: params)
      end
    end
  end

  describe '#people' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/people" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Class.people(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'first_name, last_name',
          filter: {
            first_name: [
              {
                operator: 'starts with',
                value: 'z'
              }
            ]
          }
        }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Class.people(id: id, params: params)
      end
    end
  end

  describe '#sections' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/sections" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Class.sections(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'name, description',
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
        EdLink::Class.sections(id: id, params: params)
      end
    end
  end

  describe '#students' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/students" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Class.students(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'first_name, last_name',
          filter: {
            first_name: [
              {
                operator: 'starts with',
                value: 'z'
              }
            ]
          }
        }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Class.students(id: id, params: params)
      end
    end
  end

  describe '#teachers' do
    let(:id) { 123456 }
    let(:path) { "/classes/#{id}/teachers" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::Class.teachers(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'first_name, last_name',
          filter: {
            first_name: [
              {
                operator: 'starts with',
                value: 'z'
              }
            ]
          }
        }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::Class.teachers(id: id, params: params)
      end
    end
  end
end