class AddDefaultStatusForProducts < ActiveRecord::Migration[5.1]
  def up
    Product.where(available: nil).update_all(available => "Available")
  end
end
