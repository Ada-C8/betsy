class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :product_id
      t.integer :rating
      t.string :reviewtext

      t.timestamps
    end
  end
end
