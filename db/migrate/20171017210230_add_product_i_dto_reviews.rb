class AddProductIDtoReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :product, foreign_keys: true
  end
end
