class Email

  attr_reader :original_email

  def initialize email_string
    @original_email = email_string
  end

  def header
    @header ||= header_parser.header
  end

  private

  def email_parser
    EmailParser.new( original_email )
  end

  def header_parser
    HeaderParser.new( email_parser.header )
  end

end