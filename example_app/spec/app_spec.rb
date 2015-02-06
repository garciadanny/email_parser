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

  describe '/emails' do
    let(:file_path) { File.join(File.dirname(__FILE__), 'support') }

    before do
      allow_any_instance_of(MyApp).to receive(:emails_directory).and_return file_path
    end

    it 'returns the contents of an email' do
      get '/emails/test_email'

      expect(last_response.body).to include 'Test Email'
    end
  end
end