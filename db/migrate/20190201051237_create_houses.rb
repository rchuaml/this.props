class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :name
      t.text :location
      t.integer :price
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :floor_area
      t.boolean :furnishing
      t.integer :floor_levels
      t.integer :lease_left

      t.timestamps
    end
  end
end
