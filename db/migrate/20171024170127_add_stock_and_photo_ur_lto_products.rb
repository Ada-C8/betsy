class AddStockAndPhotoUrLtoProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :stock, :string
    add_column :products, :photo_url, :string
  end
end
