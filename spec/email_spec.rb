require 'spec_helper'

describe Email do

  let(:email) { Email.new( original_email ) }

  describe '#header' do

    context 'given a raw email string' do
      it 'provides an interface to access header fields' do
        expect(email.header).to respond_to :to, :from, :subject, :date
      end

      it 'returns the name and/or email address of the recipient' do
        expect(email.header.to).to eq 'Test User <test_user@example.com>'
      end

      it 'returns the name and/or email address of the sender' do
        expect(email.header.from).to eq 'Test Sender <test_sender@example.com>'
      end

      it 'returns the subject line of the email' do
        expect(email.header.subject).to eq 'Test Email Subject'
      end

      it 'returns the date the email was sent' do
        expect(email.header.date).to eq 'Sun, 02 Feb 2015 12:37:14 -0700'
      end

      it 'returns the content type of the email' do
        expect(email.header.content_type[:value]).to eq 'multipart/alternative'
      end
    end
  end

  describe '#body' do

    context 'given a raw email string' do
      it 'provides an interface to access the message body' do
        expect(email.body).to respond_to :text_plain, :text_html
      end
    end
  end
end