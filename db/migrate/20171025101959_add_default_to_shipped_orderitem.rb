class AddDefaultToShippedOrderitem < ActiveRecord::Migration[5.1]
  def change
    change_column_default :order_items, :shipped, "not shipped"
  end
end
