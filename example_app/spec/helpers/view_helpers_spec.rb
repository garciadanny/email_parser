require 'spec_helper'

describe ViewHelpers do
  let(:helpers) { Test::Helper.new }

  describe '#email_id' do

    let(:content_type) { { value: 'text', params: {boundary: '123'} } }
    it 'returns the id (boundary) of the email' do
      expect( helpers.email_id(content_type) ).to eq '123'
    end
  end

  describe '#abbreviated_date' do

    let(:date_string) { 'Wed, 4 Feb 2015 14:50:42 -0700' }
    it 'returns the abbreviated date of a date string' do
      expect( helpers.abbreviated_date(date_string) ).to eq 'Feb 04'
    end
  end
end