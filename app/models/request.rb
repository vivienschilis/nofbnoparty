class Request < ActiveRecord::Base
  belongs_to :user
  belongs_to :party
  
  belongs_to :sender,  :class_name => "User", :foreign_key => "sender_id"
  
end
