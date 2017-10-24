class CorrectOrderProductQuantitySpelling < ActiveRecord::Migration[5.1]
  def change
    rename_column :order_products, :quanitity, :quantity
  end
end
