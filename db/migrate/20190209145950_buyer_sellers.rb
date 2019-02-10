class BuyerSellers < ActiveRecord::Migration[5.2]
  def change
    create_table :buyer_sellers do |t|
      t.integer :user1
      t.integer :user2
      t.references :house
      t.timestamps
    end
  end
end