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

  describe '#next' do
    let(:cursor) { '622bea99-3bdd-4bdc-8e55-6f87bed32dfe' }
    let(:method) { :get }
    let(:params) do
      { query: { '$cursor' => cursor } }
    end
    let(:path) { "/schools" }
    let(:url) do
      "https://ed.link/api/v2/graph#{path}"
    end

    context 'when the url is valid' do
      it 'requests the next page of data' do
        expect(EdLink::Base).to receive(:request).with(method: method, path: path, params: params)
        EdLink::Base.next(method: method, url: "#{url}?$cursor=#{cursor}")
      end
    end

    context 'when the "first" params is included' do
      let(:params) do
        { 
          query: {
            '$cursor' => cursor,
            '$first' => 1
          }
        }
      end
      let(:input_params) do
        { first: 1 }
      end

      it 'requests the next page of data' do
        expect(EdLink::Base).to receive(:request).with(method: method, path: path, params: params)
        EdLink::Base.next(method: method, url: "#{url}?$cursor=#{cursor}", params: input_params)
      end
    end

    context 'when the "method" param is not a Symbol' do
      let(:method) { 'bad-type' }

      it 'raises an ArgumentError' do
        expect{
            EdLink::Base.next(method: method, url: url)
          }.to raise_error(ArgumentError, "Expected \"method\" param to be a Symbol, got #{method.class}.")
      end
    end

    context 'when the "url" param is not a String' do
      let(:url) { :badtype }

      it 'raises an ArgumentError' do
        expect{
            EdLink::Base.next(method: method, url: url)
          }.to raise_error(ArgumentError, "Expected \"url\" param to be a String, got #{url.class}.")
      end
    end

    context 'when the "url" param is missing query params' do
      let(:url) { 'https://ed.link/api/v2/graph/schools' }

      it 'raises an ArgumentError' do
        expect{
            EdLink::Base.next(method: method, url: url)
          }.to raise_error(ArgumentError, 'Expected "url" to have a "$cursor" query param.')
      end
    end

    context 'when the "url" param is missing the $cursor query param' do
      let(:url) { 'https://ed.link/api/v2/graph/schools?search=fake' }

      it 'raises an ArgumentError' do
        expect{
            EdLink::Base.next(method: method, url: url)
          }.to raise_error(ArgumentError, 'Expected "url" to have a "$cursor" query param.')
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
      let(:payload) do
        { 
          '$data': 'Fake API response'
        }
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
            EdLink::Base.request(method: method, path: path, params: params)
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
          expect(EdLink::Base.request(method: method, path: path, params: params)).to eq(payload)
        end
      end

      context 'and expand param is a string' do
        let(:params) do
          { expand: 'district' }
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

      context 'and expand param is not a string' do
        let(:bad_type) do
          { bad: 'type' }
        end
        let(:params) do
          { expand: bad_type }
        end

        it 'raises and ArgumentError' do
          expect{
            EdLink::Base.request(method: method, path: path, params: params)
          }.to raise_error(ArgumentError, "Expected \"expand\" param to be a String, got #{bad_type.class}.")
        end
      end

      context 'and fields param is a string' do
        let(:params) do
          { fields: 'name, district_id' }
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

      context 'and fields param is not a string' do
        let(:bad_type) do
          { bad: 'type' }
        end
        let(:params) do
          { fields: bad_type }
        end

        it 'raises and ArgumentError' do
          expect{
            EdLink::Base.request(method: method, path: path, params: params)
          }.to raise_error(ArgumentError, "Expected \"fields\" param to be a String, got #{bad_type.class}.")
        end
      end

      context 'and filters param is a hash' do
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

      context 'and filters param is not a hash' do
        let(:bad_type) { 'bad' }
        let(:params) do
          { filter: bad_type }
        end

        it 'raises and ArgumentError' do
          expect{
            EdLink::Base.request(method: method, path: path, params: params)
          }.to raise_error(ArgumentError, "Expected \"filter\" param to be a Hash, got #{bad_type.class}.")
        end
      end

      context 'and first param is an integer' do
        let(:params) do
          { first: 100 }
        end
        let(:url) { "https://ed.link/api/v2/graph#{path}?$first=100" }

        before do
          stub_request(:get, url).with(headers: request_headers).to_return(
            status: 200, body: payload.to_json, headers: response_headers
          )
        end

        it 'adds first to the query params' do
          expect(EdLink::Base.request(method: method, path: path, params: params)).to eq(payload)
        end
      end

      context 'and first param is not an integer' do
        let(:bad_type) { 'bad' }
        let(:params) do
          { first: bad_type }
        end

        it 'raises and ArgumentError' do
          expect{
            EdLink::Base.request(method: method, path: path, params: params)
          }.to raise_error(ArgumentError, "Expected \"first\" param to be a Integer, got #{bad_type.class}.")
        end
      end

      context 'and all supported query params are applied' do
        let(:params) do
          {
            expand: 'district',
            fields: 'name, id, district',
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
        let(:url) do
          "https://ed.link/api/v2/graph#{path}?$expand=district&$fields=name,id,district&$filter=#{params[:filter].to_json}"
        end

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
