class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :street
      t.string :status
      t.integer :price
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :sq_ft
      t.float :lat
      t.float :lng
      t.timestamps null: false
    end
  end
end
