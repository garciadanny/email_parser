class EmailParser
  attr_reader :email_string

  def initialize email_string
    @email_string = email_string
    scanner.scan_until( empty_line_matcher )
  end

  def header
    @header ||= scanner.pre_match
  end

  def body
    @body ||= scanner.post_match
  end

  private

  def scanner
    @scanner ||= StringScanner.new( email_string )
  end

  def empty_line_matcher
    /\n\n/
  end
end