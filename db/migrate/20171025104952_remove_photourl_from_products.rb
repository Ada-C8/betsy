class RemovePhotourlFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :photo_url, :string
  end
end
