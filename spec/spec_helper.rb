Dir[File.join(File.dirname(__FILE__), '../lib', '**/*.rb')].each do |f|
  require f
end

require 'rspec'
require 'pry'
require 'helpers/original_email_helper'

RSpec.configure do |config|
  config.order = 'random'
  config.color = true
  config.include OriginalEmailHelper
end