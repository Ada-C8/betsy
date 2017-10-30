class AddForeignKeytoProduct < ActiveRecord::Migration[5.1]
  def change
    add_reference :products, :user, foreign_keys: true
  end
end
