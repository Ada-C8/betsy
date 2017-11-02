class ChangeStatusToStringForProducts < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :available, :string, :default => "Available"
  end
end
