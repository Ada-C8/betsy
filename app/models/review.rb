class Review < ApplicationRecord
  belongs_to :merchant, optional: true
  belongs_to :product

  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: { in: 1..5 }
  def average_rating
  end
end
