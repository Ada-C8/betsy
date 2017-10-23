class Review < ApplicationRecord
  belongs_to :product
  validates :rating, presence: true
  validates :product_id, presence: true
end
