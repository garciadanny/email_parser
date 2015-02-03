require 'spec_helper'

describe HeaderParser do

  let(:header_parser) { HeaderParser.new( header_string ) }
  let(:header) { header_parser.header }

  describe '#header' do

    context 'given a raw header string' do
      it 'returns a parsed header object' do
        expect(header).to respond_to :to, :from, :subject, :date, :content_type
      end
    end
  end

  it 'downcases header names' do
    header.each_pair do |name, body|
      expect(name).to eq name.downcase
    end
  end

  it 'snake_cases header names' do
    header.each_pair do |name, body|
      expect(name.to_s).to eq name.to_s.gsub('-','_')
    end
  end

  describe 'Content-Type header' do
    it 'parses the Content-Type parameters' do
      expect(header.content_type).to have_key :params
      expect(header.content_type[:params]).to have_key :boundary
    end
  end
end