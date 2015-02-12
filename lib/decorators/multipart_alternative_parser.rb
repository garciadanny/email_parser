module MultipartAlternativeParser

  private

  def parse_body
    until end_of_body? do
      body_parts[ content_subtype(header_string) ] = decode(parsed_body_string)
    end
  end

  def header_string
    scanner.scan_until( empty_line_matcher )
  end

  def body_string
    scanner.scan_until( boundary_matcher )
  end

  def parsed_body_string
    body_string.rpartition( empty_line_matcher ).first
  end

  def decode message
    message.unpack('M').pop
  end
end