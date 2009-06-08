class Something < ActiveRecord::Base
  belongs_to :party
  belongs_to :user
  
  validates_presence_of :item, :quantity
end
