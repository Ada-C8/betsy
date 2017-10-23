class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity_avail, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :merchant
  has_many :reviews
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :orders

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  def remove_one_from_stock
    if self.quantity_avail > 0
        self.quantity_avail -= 1
        self.save
        return true
    else
        return false
    end
  end

  def add_one_to_stock
    self.quantity_avail += 1
    self.save
  end

  def average_rating
    rating = 0.0
    counter = 0
    if reviews.count == 0
      return "Not yet rated!"
    end
    reviews.each do |review|
      if review[:rating] == nil
        next
      else
        rating += review[:rating]
        counter += 1
      end
    end

    rating /= counter
    return rating
  end

end
