class AddLengthToReview < ActiveRecord::Migration[5.1]
  def change
    change_column :reviews, :reviewtext, :string, length: 500
  end
end
