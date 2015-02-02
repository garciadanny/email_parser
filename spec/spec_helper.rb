Dir[File.join(File.dirname(__FILE__), '../lib', '**.rb')].each do |f|
  require f
end

require 'rspec'

RSpec.configure do |config|
  config.order = 'random'
end