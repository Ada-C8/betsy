class Product < ApplicationRecord
  has_many :order_products
  has_many :reviews
  has_many :orders, through: :order_products
  belongs_to :merchant
  has_and_belongs_to_many :categories

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0}

  def self.most_popular
    Product.all.sort_by{|p| -p.orders.count}[0...3]
  end
end
