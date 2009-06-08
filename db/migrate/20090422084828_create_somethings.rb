class CreateSomethings < ActiveRecord::Migration
  def self.up
    create_table :somethings do |t|
      t.integer :user_id
      t.integer :party_id
      t.integer :quantity
      t.string :comment
      t.string :item
      
      t.timestamps
    end
  end

  def self.down
    drop_table :somethings
  end
end
