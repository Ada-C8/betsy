class AddOrderIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :order_id, :integer
  end
end
