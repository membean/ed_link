# frozen_string_literal: true

RSpec.describe EdLink::Base do
  describe '#handle_errors' do
    [
      [400, 'BadRequestError'],
      [403, 'PermissionError'],
      [404, 'NotFoundError'],
      [429, 'RateLimitReachedError'],
      [500, 'InternalServerError']
    ].each do |status|
      context "when HTTP status is #{status[0]}" do
        let(:exception) { "EdLink::#{status[1]}".constantize }
        let(:headers) do
          { 'content-type' => ['application/json'] }
        end
        let(:json) do
          {
            '$errors': [
              {
                code: 'ERROR_CODE_EXAMPLE',
                message: message
              }
            ]
          }
        end
        let(:message) { 'This is a human-readable description of the error.' }
        let(:response) do
          instance_double(HTTParty::Response, body: json.to_json, code: status[0], headers: headers)
        end

        it "raises EdLink::#{status[1]}" do
          expect{ EdLink::Base.handle_errors(response: response)}.to raise_error{ |error|
            expect(error).to be_a(exception)
            expect(error.errors).to eq(json[:$errors])
            expect(error.headers).to eq(headers)
            expect(error.message).to eq("#{message} (1/1 errors)")
          }
        end
      end
    end
  end

  describe '#request' do
    let(:params) { {} }
    let(:method) { :get }
    let(:path) { '/fake-path' }

    context 'when access token is not configured' do
      it 'raises a ConfigurationError' do
        expect{
          EdLink::Base.request(method: method, path: path, params: params)
        }.to raise_error(EdLink::ConfigurationError)
      end
    end

    context 'when access token is configured' do
      let(:access_token) { 'FAKE-TOKEN' }
      let(:response) { double('response') }
      let(:url) { "https://ed.link/api/v2/graph#{path}" }

      let(:request_headers) do
        {
          'Accept': 'application/json',
          'Accept-Encoding': 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization': "Bearer #{access_token}",
          'Content-Type': 'application/json',
          'User-Agent': "EdLink-Ruby/#{EdLink::VERSION}"
        }
      end
      let(:response_headers) do
        { 'content-type': ['application/json'] }
      end

      # Configure the gem
      before do
        EdLink.configure do |config|
          config.access_token = access_token
        end
      end

      # Unconfigure the gem
      after do
        EdLink.configure do |config|
          config.access_token = nil
        end
      end

      context 'and the response has errors' do
        let(:payload) do
          {
            '$errors': [
              {
                code: 'ERROR_CODE_EXAMPLE',
                message: 'This is a human-readable description of the error.'
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
            EdLink::Base.request(method: method, path: path, params: params)
          }.to raise_error(EdLink::BadRequestError)
        end
      end

      context 'and the response is succcessful' do
        let(:payload) do
          { 
            '$data': 'Fake API response'
          }
        end

        before do
          stub_request(:get, url).with(headers: request_headers).to_return(
            status: 200, body: payload.to_json, headers: response_headers
          )
        end

        it 'returns the API response' do
          expect(EdLink::Base.request(method: method, path: path, params: params)).to eq(payload)
        end
      end

      context 'and expand is applied' do
        let(:params) do
          { expand: 'district' }
        end
        let(:payload) do
          { 
            '$data': 'Fake API response'
          }
        end
        let(:url) { "https://ed.link/api/v2/graph#{path}?$expand=district" }

        before do
          stub_request(:get, url).with(headers: request_headers).to_return(
            status: 200, body: payload.to_json, headers: response_headers
          )
        end

        it 'adds expand to the query params' do
          expect(EdLink::Base.request(method: method, path: path, params: params)).to eq(payload)
        end
      end

      context 'and fields are selected' do
        let(:params) do
          { fields: 'name, district_id' }
        end
        let(:payload) do
          { 
            '$data': 'Fake API response'
          }
        end
        let(:url) { "https://ed.link/api/v2/graph#{path}?$fields=name,district_id" }

        before do
          stub_request(:get, url).with(headers: request_headers).to_return(
            status: 200, body: payload.to_json, headers: response_headers
          )
        end

        it 'adds fields to the query params' do
          expect(EdLink::Base.request(method: method, path: path, params: params)).to eq(payload)
        end
      end

      context 'and filters are applied' do
        let(:params) do
          {
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
        let(:payload) do
          { 
            '$data': 'Fake API response'
          }
        end
        let(:url) { "https://ed.link/api/v2/graph#{path}?$filter=#{params[:filter].to_json}" }

        before do
          stub_request(:get, url).with(headers: request_headers).to_return(
            status: 200, body: payload.to_json, headers: response_headers
          )
        end

        it 'adds filter to the query params' do
          expect(EdLink::Base.request(method: method, path: path, params: params)).to eq(payload)
        end
      end
    end
  end
end
