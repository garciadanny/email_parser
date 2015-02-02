module OriginalEmailHelper

  def original_email
    location = file_location( 'test_email.txt' )
    File.open(location, 'r') { |file| file.read }
  end

  def header_string
    location = file_location( 'test_header.txt' )
    File.open(location, 'r') { |file| file.read }
  end

  def body_string
    location = file_location( 'test_body.txt' )
    File.open(location, 'r') { |file| file.read }
  end

  def file_location file_name
    File.join(File.dirname(__FILE__), "../test_emails/#{file_name}")
  end
end