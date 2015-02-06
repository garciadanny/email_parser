require_relative 'parsers/email_parser'
require_relative 'parsers/header_parser'
require_relative 'parsers/body_parser'

class Email

  attr_reader :original_email

  def initialize email_string
    @original_email = email_string
  end

  def header
    @header ||= header_parser.header
  end

  def body
    @body ||= body_parser.body
  end

  private

  def email_parser
    EmailParser.new( original_email )
  end

  def header_parser
    HeaderParser.new( email_parser.header )
  end

  def body_parser
    BodyParser.new( header.content_type, email_parser.body )
  end

end