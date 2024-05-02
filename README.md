# EdLink

A very thin wrapper around the [EdLink Graph API (v2)](https://ed.link/docs/api/v2.0/introduction).

## Installation

Add this line to your application's Gemfile:

    $ gem 'ed_link'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install ed_link

## Configuration
API keys must be configured in the gem setup. You can do this anywhere in your application before you make API calls using the gem.

```ruby
# config/initializers/ed_link.rb
EdLink.configure do |config|
  config.access_token = ENV['EDLINK_API_TOKEN']
end
```

## Usage

Expects an `ENV` variable called `EDLINK_API_TOKEN` that is a valid API access token for the EdLink Graph API. [Take a look at each resource](https://github.com/membean/ed_link/tree/main/lib/ed_link) to see the methods that correspond to the endpoints in the [EdLink Graph API documentation](https://ed.link/docs/api/v2.0/introduction).

The [EdLink Developer Guides](https://ed.link/docs/guides/v2.0/introduction) have more information that is important to review:

- [Common Error Codes](https://ed.link/docs/api/v2.0/responses/errors)
- [Expanding Results](https://ed.link/docs/guides/v2.0/features/expanding-results)
- [Filtering](https://ed.link/docs/guides/v2.0/features/filtering-results)
- [Limiting Response Fields](https://ed.link/docs/guides/v2.0/features/limiting-fields)
- [Pagination](https://ed.link/docs/guides/v2.0/features/paginated-requests)
- [Privacy](https://ed.link/docs/guides/v2.0/security/privacy)
- [Security](https://ed.link/docs/guides/v2.0/security/data-security)
- [Warnings](https://ed.link/docs/api/v2.0/responses/warnings)


Query parameters for API requests are supported, and should be included in a single hash. For example, if you want to apply query parameters to the `EdLink::School.all` method you would call it like `EdLink::School.all(params: params)`.

Note, most [pagination parameters](https://ed.link/docs/guides/v2.0/features/paginated-requests) are not currently supported as we encourage you to use the preferred way to paginate results by using the `$next` URL. However, the gem does support the `$first` pagination parameter as a means of adjusting the page size.

**Currently supported query parameters:**

```ruby 
{
  # "expand" must be a String with a specific value based on the
  # resource you are trying to expand.
  # https://ed.link/docs/guides/v2.0/features/expanding-results
  expand: 'district',
  # "fields" must be a String of comma-separated field names that you
  # want to include in the response.
  # https://ed.link/docs/guides/v2.0/features/limiting-fields
  fields: 'name, id',
  # "filter" must be a Hash with a specific structure based on the
  # resource you are accessing.
  # https://ed.link/docs/guides/v2.0/features/filtering-results
  filter: {
    name: [
      {
        operator: 'starts with',
        value: 'r'
      }
    ]
  },
  # "first" must be an Integer and will be disregarded by the API if
  # it is larger than 10,000. (Default is 100.)
  # https://ed.link/docs/guides/v2.0/features/paginated-requests
  first: 100
}
```

## Examples

```ruby
EdLink::District.all
#=> {
#     :$data=> [
#       {
#         :created_date=>"2024-04-19T01:14:38.391Z",
#         :updated_date=>"2024-04-19T01:14:38.391Z",
#         :name=>"Edlink",
#         ...,
#         :id=>"08a5422e-13f4-4c0a-ba0f-e46f547ffc53"
#       }
#     ],
#     :$request=>"d1c5f7eb-8d6c-4456-92ac-8c528d374e78"
#   }
```

```ruby 
EdLink::School.find(id: 'e8b207c7-7b80-477c-ae7b-6020de91d46f')
#=> {
#     :$data=> [
#       {
#         :created_date=>"2024-04-19T01:14:38.391Z",
#         :updated_date=>"2024-04-19T01:14:38.391Z",
#         :name=>"Edlink (District Office)",
#         ...,
#         :id=>"e8b207c7-7b80-477c-ae7b-6020de91d46f"
#       }
#     ],
#     :$request=>"e6e5a17f-cc84-46ee-91bb-9bec990444f9"
#   }
```

```ruby 
# Returns only the "name" and "id" fields for schools whose name starts
# with the letter "z":
params: {
  fields: 'name, id',
  filter: {
    name: [
      {
        operator: 'starts with',
        value: 'r'
      }
    ]
  }
}
EdLink::School.all(params: params)
#=> {
#     :$data=> [
#       {
#         :name=>"Rosen School",
#         :id=>"d905586d-4245-4223-b2ae-8d8f5b665844"
#       }
#     ],
#     :$request=>"50bcd21d-4c01-4cb3-af22-b5f65483ba6a"
#   }
```

```ruby 
# Returns only the "name" and "id" fields and expands the "district_id" field for
# a single school. (Notice that we are including the expanded field name "district")
# in the "fields" param.
params: {
  expand: 'district',
  fields: 'name, id, district'
}
EdLink::School.find(id: 'e8b207c7-7b80-477c-ae7b-6020de91d46f')
#=> {
#     :$data=> [
#       {
#         :name => "Edlink (District Office)",
#         :id => "e8b207c7-7b80-477c-ae7b-6020de91d46f"
#         :district => {
#           :created_date => "2024-04-19T01:14:38.391Z",
#           :updated_date =>"2024-04-19T01:14:38.391Z",
#           :name => "Edlink",
#           ...
#           :id => "08a5422e-13f4-4c0a-ba0f-e46f547ffc53"
#         }
#       }
#     ],
#     :$request= > "50bcd21d-4c01-4cb3-af22-b5f65483ba6a"
#   }
```

```ruby 
# Returns only 1 result per "page" and illustrates the $next key for
# pagination.
params: {
  first: 1,
  fields: 'name, id'
}
EdLink::School.all(params: params)
#=> {
#     :$data=> [
#       {
#         :name =>  "Edlink (District Office)",
#         :id => "e8b207c7-7b80-477c-ae7b-6020de91d46f"
#       }
#     ],
#     :$next => "https://ed.link/api/v2/graph/schools?$cursor=46aef3e1-e9a7-4167-9da7-85999f34310e",
#     :$request => "904a6cc7-65ce-40b1-b400-892bf6dcd956"
#   }

# Using the $next URL to retrieve the next page of results:
EdLink::School.next(url: 'https://ed.link/api/v2/graph/schools?$cursor=46aef3e1-e9a7-4167-9da7-85999f34310e')
#=> {
#     :$data: [
#       {
#         :name => "Eddie Lynx",
#         :id => "10ae266b-a974-4875-8f4e-5aa52a7af9f3"
#       }
#    ],
#    :$next => "https://ed.link/api/v2/graph/schools?$cursor=48f1e496-e5b2-436d-a57d-df2451fa5f34",
#    :$request => "18be1073-549e-462b-ad8d-1049216931bb"
#  }
```

```ruby 
# Errors
school = EdLink::School.find(id: 'e8b207c7')
#=> EdLink::BadRequestError: A valid v4 or v5 UUID or Alias is expected for parameter 'school_id'. (1/1 errors)

begin
  school = EdLink::School.find(id: 'e8b207c7')
rescue EdLink::BadRequestError => error
  # Show the array of errors that came back from the API
  # (only the first error is shown in the exception messege)
  puts error.errors
  # Show the response headers from the API
  # (Edlink will probably add rate limiting/throttling in the future)
  puts error.headers 
end

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/membean/ed_link.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
