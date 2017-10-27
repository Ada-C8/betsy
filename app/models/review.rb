class Review < ApplicationRecord
  belongs_to :merchant, optional: true
  belongs_to :product

  validates :rating, presence: true, numericality: { only_integer: true }, inclusion: { in: 1..5 }

  def self.get_rating_stars(rating)
    stars = ""

    return stars if !(rating.is_a? Numeric)

    if rating <= 1
      stars = "⭑⭒⭒⭒⭒"
    elsif rating <= 2
      stars = "⭑⭑⭒⭒⭒"
    elsif rating <= 3
      stars = "⭑⭑⭑⭒⭒"
    elsif rating <= 4
      stars = "⭑⭑⭑⭑⭒"
    else
      stars = "⭑⭑⭑⭑⭑"
    end

    return stars
  end
end
