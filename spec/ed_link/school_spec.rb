# frozen_string_literal: true

RSpec.describe EdLink::School do
  let(:method) { :get }

  before do
    expect(EdLink::School).to receive(:request).with(method: method, path: path, params:params)
  end

  describe '#administrators' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/administrators" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::School.administrators(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'first_name, last_name',
            first_name: [
              {
                operator: 'starts with',
                value: 'z'
              }
            ]
          }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::School.administrators(id: id, params: params)
      end
    end
  end

  describe '#all' do
    let(:path) { '/schools' }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::School.all
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
        EdLink::School.all(params: params)
      end
    end
  end

  describe '#classes' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/classes" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::School.classes(id: id, params: params)
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
        EdLink::School.classes(id: id, params: params)
      end
    end
  end

  describe '#courses' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/courses" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::School.courses(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'name, code',
          filter: {
            code: [
              {
                operator: 'equals',
                value: 'abc'
              }
            ]
          }
        }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::School.courses(id: id, params: params)
      end
    end
  end

  describe '#find' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}" }

    context 'with no params' do
      let(:params) { {} }
    
      it 'calls the correct API endpoint' do
        EdLink::School.find(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'name, id' }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::School.find(id: id, params: params)
      end
    end
  end

  describe '#people' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/people" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::School.people(id: id)
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
        EdLink::School.people(id: id, params: params)
      end
    end
  end

  describe '#sessions' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/sessions" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::School.sessions(id: id)
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
        EdLink::School.sessions(id: id, params: params)
      end
    end
  end

  describe '#students' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/students" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::School.students(id: id)
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
        EdLink::School.students(id: id, params: params)
      end
    end
  end

  describe '#teachers' do
    let(:id) { 123456 }
    let(:path) { "/schools/#{id}/teachers" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::School.teachers(id: id)
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
        EdLink::School.teachers(id: id, params: params)
      end
    end
  end
end