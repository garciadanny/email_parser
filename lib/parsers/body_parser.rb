# RFC 1341
# 7.2 and 7.2.1
# Multiple part messages must contain a "multipart" Content-Type header field
# and a *required* boundary parameter which is used to define the encapsulation
# boundary. The body must contain one or more 'body parts' each preceded by
# an encapsulation boundary, and the last one followed by a closing boundary.
#
# Each part starts with:
# 1. an encapsulation boundary,
# 2. and then contains a body part consisting of header area
# 3. a blank line
# 4. and a body area.
#
# A boundary beginning with "--" defines the beginning of a body part
# A boundary beginning with "--" and ending with "--" defines the end of all the body parts.
# 7.2.3
# The "alternative" subtype means that each body part is an alternative version of the *same*
# information. The last body part is usually the "best" type based on the user's environment.

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