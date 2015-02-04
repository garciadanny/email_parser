require 'spec_helper'

describe BodyParser do

  let(:header) { HeaderParser.new( header_string ).header }
  let(:body_parser) { BodyParser.new( header.content_type, body_string ) }

  describe '#body' do

    let(:body) { body_parser.body }

    context 'given a raw body string' do

      it 'parses the plain text version of the email body' do
        expect(body.text_plain).to eq 'This is the body of the test email.'
      end

      it 'parses the html version of the email body' do
        html = "<div dir=\"ltr\">This is the body of the test email.</div>"
        expect(body.text_html).to eq html
      end
    end
  end

  describe 'decorator' do

    context 'given an email with a multipart/alternative content type' do

      it 'decorates BodyParser with the appropriate parsing module' do
        decorators = body_parser.singleton_class.included_modules
        expect(decorators).to include MultipartAlternativeParser
      end
    end
  end
end