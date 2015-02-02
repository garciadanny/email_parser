require 'spec_helper'

describe EmailParser do

  let(:email) { original_email }
  let(:email_parser) { EmailParser.new( email ) }

  describe '#header' do
    context 'given an original email string' do

      it 'should parse out the header section' do
        expect(email_parser.header).to eq header_string
      end
    end
  end
end