class AddPhotoUrlToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :photo_URL, :string
  end
end
