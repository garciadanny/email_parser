require_relative '../decorators/multipart_alternative_parser'
require 'ostruct'

class BodyParser
  attr_reader :content_type, :body_string

  def initialize content_type, body_string
    @content_type = content_type
    @body_string = body_string
    self.extend decorator
    parse_body
  end

  def body
    @body ||= OpenStruct.new( body_parts )
  end

  private

  def scanner
    @scanner ||= StringScanner.new( body_string )
  end

  def empty_line_matcher
    /\n\n/
  end

  def content_type_matcher
    /Content-Type:[^;]*/
  end

  def decorator
    decorator = body_type.split('/').map { |x| x.capitalize }.join
    Object.const_get( "#{decorator}Parser" )
  end

  def body_type
    content_type[:value]
  end

  def end_of_body?
    scanner.check_until( empty_line_matcher ).nil?
  end

  def subtype header_string
    content_type = header_string.scan(content_type_matcher).join
    subtype = content_type.split(':', 2).last
    subtype.strip.gsub('/', '_')
  end

  def body_parts
    @parts ||= {}
  end
end