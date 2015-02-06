module ViewHelpers
  def abbreviated_date date
    Date.parse(date).strftime("%b %d")
  end

  def email_id content_type
    # Use the email's unique encapsulation boundary
    # as it's path (unique id)
    content_type[:params][:boundary]
  end
end