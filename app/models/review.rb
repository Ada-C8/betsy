class Review < ApplicationRecord
  belongs_to :product

  validates :rating, presence: true, numericality: { only_integer: true, allow_nil: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5  }

  validates :reviewtext, length: { maximum: 500, too_long: "%{count} characters is the maximum allowed" }
end
