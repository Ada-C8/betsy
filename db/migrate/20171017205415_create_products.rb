class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.decimal :price
      t.integer :quantity_avail
      t.belongs_to :merchant, index: true
      t.timestamps
    end
  end
end
