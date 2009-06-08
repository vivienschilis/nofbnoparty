class FacebookPublisher < Facebooker::Rails::Publisher
  
  def new_party_notification(user, targets, party)
    send_as :notification
    from user
    fbml "organize a new party #{party.title} on #{party.date.to_s}"
    recipients targets
  end
  
  
end
