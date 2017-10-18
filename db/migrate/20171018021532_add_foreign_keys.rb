class AddForeignKeys < ActiveRecord::Migration[5.1]
  def change
    add_column :order_products, :order_id, :integer
    add_column :order_products, :product_id, :integer

    add_column :products, :merchant_id, :integer

    add_column :orders, :merchant_id, :integer

    add_column :reviews, :merchant_id, :integer
    add_column :reviews, :product_id, :integer
  end
end
