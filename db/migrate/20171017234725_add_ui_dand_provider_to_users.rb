class AddUiDandProviderToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :uid, :string, null: false
    add_column :users, :provider, :string, null: false
  end
end
