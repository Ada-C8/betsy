class SetLengthToReview < ActiveRecord::Migration[5.1]
  def self.down
    change_column :reviews, :reviewtext
  end
  def self.up
    change_column :reviews, :reviewtext, :string, length: 500
  end
end
