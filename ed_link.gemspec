# frozen_string_literal: true

require_relative "lib/ed_link/version"

Gem::Specification.new do |spec|
  spec.name = "ed_link"
  spec.version = EdLink::VERSION
  spec.authors = ["Brian Getting"]
  spec.email = ["brian@membean.com"]

  spec.summary       = "A very thin wrapper for interacting with the EdLink API."
  spec.description   = "A very thin wrapper for interacting with the EdLink API. Returns a hash of the API response, and provides messaging when errors are returned."
  spec.homepage      = "https://github.com/membean/ed_link"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/membean/ed_link"
  spec.metadata["changelog_uri"] = "https://github.com/membean/ed_link/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "activesupport", ">= 7"
  spec.add_dependency "csv", ">= 3"
  spec.add_dependency "httparty", "~> 0.2"
  spec.add_development_dependency "pry", "~> 0.1"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "webmock", "~> 3"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
