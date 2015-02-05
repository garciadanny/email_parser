require 'spec_helper'

describe MyApp do
  include Rack::Test::Methods

  def app
    MyApp
  end

  describe '/' do
    it 'provides instructions for the user' do
      get '/'

      expect(last_response).to be_ok
      expect(last_response.body).to include "Open one of the emails above to see it's content!"
    end
  end
end