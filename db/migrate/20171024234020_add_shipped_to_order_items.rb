class AddShippedToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :shipped, :string
  end
end
