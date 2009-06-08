class AddSenderIdToRequest < ActiveRecord::Migration
  def self.up
    add_column :requests, :sender_id, :integer, :default => :null
  end

  def self.down
    remove_column :requests, :sender_id
  end
end
