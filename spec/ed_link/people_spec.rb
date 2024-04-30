# frozen_string_literal: true

RSpec.describe EdLink::People do
  let(:method) { :get }

  before do
    expect(EdLink::People).to receive(:request).with(method: method, path: path, params:params)
  end

  describe '#agents' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/agents" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::People.agents(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'relationship, id',
          filter: {
            relationship: [
              {
                operator: 'equals',
                value: 'parent'
              }
            ]
          }
        }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::People.agents(id: id, params: params)
      end
    end
  end
  
  describe '#all' do
    let(:path) { '/people' }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::People.all
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
        EdLink::People.all(params: params)
      end
    end
  end

  describe '#classes' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/classes" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::People.classes(id: id)
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
        EdLink::People.classes(id: id, params: params)
      end
    end
  end

  describe '#districts' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/districts" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::People.districts(id: id)
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
        EdLink::People.districts(id: id, params: params)
      end
    end
  end

  describe '#enrollments' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/enrollments" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::People.enrollments(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        {
          fields: 'role, id',
          filter: {
            role: [
              {
                operator: 'equals',
                value: 'teacher'
              }
            ]
          }
        }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::People.enrollments(id: id, params: params)
      end
    end
  end

  describe '#find' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}" }

    context 'with no params' do
      let(:params) { {} }
    
      it 'calls the correct API endpoint' do
        EdLink::People.find(id: id)
      end
    end

    context 'with params' do
      let(:params) do
        { fields: 'first_name, last_name' }
      end
      
      it 'calls the API endpoint with the proper params' do
        EdLink::People.find(id: id, params: params)
      end
    end
  end

  describe '#schools' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/schools" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::People.schools(id: id)
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
        EdLink::People.schools(id: id, params: params)
      end
    end
  end

  describe '#sections' do
    let(:id) { 123456 }
    let(:path) { "/people/#{id}/sections" }

    context 'with no params' do
      let(:params) { {} }

      it 'calls the correct API endpoint' do
        EdLink::People.sections(id: id)
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
        EdLink::People.sections(id: id, params: params)
      end
    end
  end
end