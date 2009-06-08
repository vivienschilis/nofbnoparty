require 'redcloth'

class Party < ActiveRecord::Base
  has_many :requests
  has_many :users, :through => :requests
  belongs_to :user

  validates_presence_of :date, :title
  
  has_many :waiting_requests,  :class_name => "Request",
    :conditions => "accepted_at is NULL AND sender_id = 0"
    
  has_many :invited_request,  :class_name => "Request",
    :conditions => "accepted_at is not NULL"
  
  has_many :waiting_users,  :class_name => "User", :foreign_key => "user_id", :source=> "user", :through => :requests,
    :conditions => "accepted_at is NULL"
    
  has_many :invited_users,  :class_name => "User", :foreign_key => "user_id", :source=> "user", :through => :requests,
    :conditions => "accepted_at is not NULL", :order => "accepted_at DESC"

  has_many :waiting_accepts,  :class_name => "Request",
      :conditions => "accepted_at is NULL AND sender_id <> 0"

  def content_html
    RedCloth.new(content).to_html
  end
  
  def request_of(user)
    Request.find_by_user_id_and_party_id(user.id, id)
  end
end
