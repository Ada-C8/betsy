class CreateOrderProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :order_products do |t|
      t.string :status
      t.integer :quantity
      t.timestamps
    end
  end
end
