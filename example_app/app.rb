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

  get '/emails/:id' do
    file_location = "#{emails_directory}/#{params[:id]}.txt"
    @email = Email.new( email_string(file_location) )
    erb :show
  end
end