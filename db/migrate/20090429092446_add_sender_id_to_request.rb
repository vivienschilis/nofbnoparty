class AddSenderIdToRequest < ActiveRecord::Migration
  def self.up
    add_column :requests, :sender_id, :integer
  end

  def self.down
    remove_column :requests, :sender_id
  end
end
