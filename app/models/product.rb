class Product < ApplicationRecord
  belongs_to :merchant
  belongs_to :category
  has_many :order_products
  has_many :orders, through: :order_products
  has_many :reviews, dependent: :destroy


  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :merchant_id, presence: true
  validates :category_id, presence: true

end
