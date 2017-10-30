class AddUserIDtoReviews < ActiveRecord::Migration[5.1]
  def change
    add_reference :reviews, :user, foreign_keys: true
  end
end
