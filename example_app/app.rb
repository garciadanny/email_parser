require 'sinatra'
require_relative 'helpers/utils'
require_relative 'helpers/view_helpers'
require_relative '../lib/email'

class MyApp < Sinatra::Application

  helpers Utils, ViewHelpers

  before do
    @emails = email_list
  end

  get '/' do
    erb :index
  end
end