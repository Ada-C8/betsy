class AddStatusToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :available, :boolean, :default => true
  end
end
