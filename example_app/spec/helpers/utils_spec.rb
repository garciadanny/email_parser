require 'spec_helper'

describe Utils do
  let(:helpers) { Test::Helper.new }

  describe '#email_list' do
    it 'returns a list of email objects' do
      expect(helpers.email_list).to be_a Array
      expect(helpers.email_list.sample).to be_a Email
    end
  end

  describe '#email_string' do

    context 'given a file path' do
      let(:file_path) { File.join(File.dirname(__FILE__), '../support/test_email.txt') }

      it 'returns a raw email string' do
        email_string = helpers.email_string(file_path)
        expect( email_string ).to include 'Test Email'
      end
    end
  end
end