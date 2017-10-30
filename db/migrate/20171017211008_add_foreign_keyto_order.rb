class AddForeignKeytoOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :user, foreign_keys: true
    add_reference :orders, :cart, foreign_keys: true
  end
end
