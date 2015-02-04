# RFC 2822
# 2.1
# The body is a sequence of characters that follows the header and is separated
# from the header section by an **empty line**. CRLF Ex:
# 1. Header
# 2. Empty line
# 3. Body
#
# 2.2
# Header fields begin with a field name followed by a ":" followed by a field body
# and terminated with a CRLF (newline).

require 'ostruct'

class HeaderParser
  attr_reader :header_string

  def initialize header_string
    @header_string = header_string
  end

  def header
    @header ||= OpenStruct.new( header_fields.merge(content_type) )
  end

  private

  def header_fields
    @fields ||= field_list.each_with_object({}) do |string, hash|
      field = header_field( string )
      hash[ field[:name] ] = field[:body]
    end
  end

  def field_list
    header_string.strip.split("\n")
  end

  def header_field string
    name, body = string.split(':', 2)
    { name: field_name(name), body: field_body(body) }
  end

  def field_name string
    string.downcase.gsub('-', '_')
  end

  def field_body string
    body = string.strip
  end

  def content_type
    parts = header_fields['content_type'].split(';')
    value = { value: parts.shift, params: parameters( parts ) }
    {content_type: value }
  end

  def parameters params
    params.each_with_object({}) do |string, hash|
      name, value = string.strip.split('=')
      hash[name.to_sym] = value
    end
  end
end