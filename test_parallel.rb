# Current configuration setup using class variable
def fetch_edlink_data(token:)
  EdLink.configuration.access_token = token
  EdLink::District.all(params: { mock: true })
  EdLink.configuration.access_token = nil
end

# Updated configuration setup using CurrentAttributes
def fetch_edlink_data_v2(token:)
  EdLink::Current.access_token = token
  EdLink::District.all(params: { mock: true })
  EdLink::Current.access_token = nil
end

def fetch_all(tokens: [], use_v2: false)
  threads = []
  tokens.each.with_index do |token, i|
    threads << Thread.new do
      Thread.current.name = "thread#{i+1}_#{token}"
      use_v2 ? fetch_edlink_data_v2(token: token) : fetch_edlink_data(token: token)
    end
  end
  threads
end

require 'bundler/setup'
require 'ed_link'

module EdLink
  module MockRequest
    def request(method:, path:, params: {})
      token = EdLink::Current.access_token || EdLink.configuration.access_token
      puts "In [#{Thread.current.name}]: Using token - #{token}"
      sleep(rand(3..6))
      puts "In [#{Thread.current.name}]: Current token - #{token}"
      sleep(2)
      return {}
    end
  end
end

EdLink::District.extend EdLink::MockRequest

puts "Testing old config setup..."
threads = fetch_all(tokens: %w[token1 token2])
threads.map(&:join)

puts "Waiting..."
sleep(2)

puts "\nTesting new config setup..."
threads = fetch_all(tokens: %w[token1 token2], use_v2: true)
threads.map(&:join)
puts "Done"
