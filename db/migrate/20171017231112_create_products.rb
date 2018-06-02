class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :image_url
      t.string :category
      t.float :price
      t.integer :quantity
      t.text :description
      t.timestamps
    end
  end
end
