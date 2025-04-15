# frozen_string_literal: true

RSpec.describe EdLink::MetaBase do
  describe '#request' do
    let(:params) { {} }
    let(:method) { :get }
    let(:path) { '/fake-path' }

    context 'when app secret is not configured' do
      it 'raises a ConfigurationError' do
        expect{
          EdLink::MetaBase.request(method: method, path: path, params: params)
        }.to raise_error(EdLink::ConfigurationError)
      end
    end

    context 'when app secret is configured' do
      let(:app_secret) { 'FAKE-SECRET' }
      let(:response) { double('response') }
      let(:url) { "https://ed.link/api/v1#{path}" }

      let(:request_headers) do
        {
          'Accept': 'application/json',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization': "Bearer #{app_secret}",
          'Content-Type': 'application/json',
          'User-Agent': "EdLink-Ruby/#{EdLink::VERSION}"
        }
      end
      let(:response_headers) do
        { 'content-type': ['application/json'] }
      end
      let(:payload) do
        { 
          '$data': 'Fake API response'
        }
      end

      # Configure the gem
      before do
        EdLink.configure do |config|
          config.app_secret = app_secret
        end
      end

      # Unconfigure the gem
      after do
        EdLink.configure do |config|
          config.app_secret = nil
        end
      end

      context 'and the response has errors' do
        let(:message) { 'This is a human-readable description of the error.' }
        let(:payload) do
          {
            '$errors': [
              {
                code: 'ERROR_CODE_EXAMPLE',
                message: message
              }
            ]
          }
        end

        before do
          # We're mocking a BadRequestError response from the API.
          stub_request(:get, url).with(headers: request_headers).to_return(
            status: 400, body: payload.to_json, headers: response_headers
          )
        end

        it 'raises an error' do
          expect{
            EdLink::MetaBase.request(method: method, path: path, params: params)
          }.to raise_error(EdLink::BadRequestError, "#{message} (1/1 errors)")
        end
      end

      context 'and the response is succcessful' do
        before do
          stub_request(:get, url).with(headers: request_headers).to_return(
            status: 200, body: payload.to_json, headers: response_headers
          )
        end

        it 'returns the API response' do
          expect(EdLink::MetaBase.request(method: method, path: path, params: params)).to eq(payload)
        end
      end
    end
  end
end
