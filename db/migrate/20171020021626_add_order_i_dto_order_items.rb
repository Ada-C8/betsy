class AddOrderIDtoOrderItems < ActiveRecord::Migration[5.1]
  def change
    # add_column :order_items, :order_id, :bigint
    add_reference :order_items, :order, foreign_keys: true
  end
end
