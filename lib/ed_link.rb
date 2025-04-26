# frozen_string_literal: true

require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string/inflections'
require 'httparty'
require 'json'

require_relative 'ed_link/configuration'
require_relative 'ed_link/version'

require_relative 'ed_link/base'
require_relative 'ed_link/class'
require_relative 'ed_link/course'
require_relative 'ed_link/district'
require_relative 'ed_link/enrollment'
require_relative 'ed_link/errors'
require_relative 'ed_link/people'
require_relative 'ed_link/school'
require_relative 'ed_link/session'

module EdLink
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
