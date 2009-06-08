class CreateParties < ActiveRecord::Migration
  def self.up
    create_table :parties do |t|
      t.timestamp :date
      t.string :city
      t.string :address
      t.integer :zipcode
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :parties
  end
end
