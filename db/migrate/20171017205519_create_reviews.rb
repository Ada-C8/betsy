class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :text_review
      t.belongs_to :product, index: true
      t.timestamps
    end
  end
end
