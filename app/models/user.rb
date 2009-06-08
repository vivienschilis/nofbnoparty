class User < ActiveRecord::Base
  has_many :parties
  has_many :requests
  
  has_many :owned_parties,  :class_name => "Party", :foreign_key => "user_id"
  
  has_many :pending_parties,  :class_name => "Party", :foreign_key => "party_id", 
    :source =>"party", :through => :requests, :conditions => "accepted_at IS NULL AND sender_id = 0"
  
  has_many :accepted_parties,  :class_name => "Party", :foreign_key => "party_id",
    :source =>"party", :through => :requests, :conditions => "accepted_at IS not NULL"
    
  has_many :requested_parties,  :class_name => "Request", :conditions => "accepted_at IS NULL AND sender_id <> 0"
end
