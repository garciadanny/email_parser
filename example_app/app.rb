require 'sinatra'

class MyApp < Sinatra::Application

  get '/' do
    erb :index
  end
end