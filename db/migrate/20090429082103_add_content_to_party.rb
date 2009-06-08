class AddContentToParty < ActiveRecord::Migration
  def self.up
    add_column :parties, :content, :text
  end

  def self.down
    remove_column :parties, :content
  end
end
