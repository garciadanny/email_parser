module MultipartAlternativeParser

  private

  def parse_body
    until end_of_body? do
      header_string = scanner.scan_until( empty_line_matcher )
      body_string = scanner.scan_until( empty_line_matcher )
      body_parts[ subtype(header_string) ] = body_string.strip
    end
  end
end