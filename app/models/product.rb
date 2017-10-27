class Product < ApplicationRecord
  # TODO: add this back after demo
  # belongs_to :merchant
  belongs_to :category
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :reviews, dependent: :destroy


  validates :name, presence: true
  validates :price, presence: true, numericality: {
    greater_than: 0
  }
  validates :stock, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    only_integer: true
  }
  # TODO: add this back after demo
  # validates :merchant_id, presence: true
  validates :category_id, presence: true

  def average_rating
    reviews.average(:rating)
  end
  # validates_associated :merchant, :category

end
