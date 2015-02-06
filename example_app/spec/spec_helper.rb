ENV['RACK_ENV'] = 'test'

require_relative '../app'
require_relative '../helpers/utils'
require_relative '../helpers/view_helpers'
require_relative 'support/test_helper'
require 'rspec'
require 'rack/test'
require 'pry'

RSpec.configure do |config|
  config.order = 'random'
  config.color = true
  config.include Test
end