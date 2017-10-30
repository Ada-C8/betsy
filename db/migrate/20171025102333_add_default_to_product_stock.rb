class AddDefaultToProductStock < ActiveRecord::Migration[5.1]
  def change
    change_column_default :products, :stock, "In Stock"
  end
end
