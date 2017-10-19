class Product < ApplicationRecord
  has_many :order_products
  has_many :reviews
  has_many :orders, through: :order_products
  belongs_to :merchant

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: {greater_than: 0}
  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0}
end
