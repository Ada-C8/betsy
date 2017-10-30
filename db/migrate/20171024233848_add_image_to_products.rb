class AddImageToProducts < ActiveRecord::Migration[5.1]
  def change
    add_attachment :products, :photo
  end

  def self.up
    add_attachment :products, :photo
  end

  def self.down
    remove_attachment :products, :photo
  end
end
