# frozen_string_literal: true

RSpec.describe EdLink::District do
  let(:method) { :get }

  describe '#administrators' do
    subject { EdLink::District.administrators(id: id) }
    
    let(:path) { "/districts/#{id}/administrators" }
    let(:id) { 123456 }

    it 'calls the correct API endpoint' do
      expect(EdLink::District).to receive(:request).with(method: method, path: path)
      subject
    end
  end

  describe '#all' do
    subject { EdLink::District.all }

    let(:path) { '/districts' }

    it 'calls the correct API endpoint' do
      expect(EdLink::District).to receive(:request).with(method: method, path: path)
      subject
    end
  end

  describe '#find' do
    subject { EdLink::District.find(id: id) }
    
    let(:path) { "/districts/#{id}" }
    let(:id) { 123456 }

    it 'calls the correct API endpoint' do
      expect(EdLink::District).to receive(:request).with(method: method, path: path)
      subject
    end
  end
end