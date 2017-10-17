class Product < ApplicationRecord
  has_many :orderproducts
  has_many :reviews
  has_many :orders, through: :orderproducts,
  belongs_to :merchant

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: true, greater_than: 0
  validates :quantity, presence: true, numericality: true, greater_than_or_equal_to: 0
end
