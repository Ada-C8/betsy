class AddNameToBilling < ActiveRecord::Migration[5.1]
  def change
    add_column :billings, :name, :string
  end
end
