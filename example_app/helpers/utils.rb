module Utils
  def email_list
    files = Dir[File.join("#{emails_directory}", '*.txt')]
    files.map { |file| Email.new( email_string(file) ) }
  end

  def email_string file_path
    File.open(file_path, 'r') { |file| file.read }
  end

  private

  def emails_directory
    File.join(File.dirname(__FILE__), '../public/emails')
  end
end