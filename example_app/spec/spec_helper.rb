ENV['RACK_ENV'] = 'test'

require_relative '../app'
require 'rspec'
require 'rack/test'
require 'pry'

RSpec.configure do |config|
  config.order = 'random'
  config.color = true
end