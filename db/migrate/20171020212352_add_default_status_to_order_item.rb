class AddDefaultStatusToOrderItem < ActiveRecord::Migration[5.1]
  def change
    change_column :order_items, :status, :string, default: "pending"
  end
end
