class Product < ApplicationRecord
  has_many :orderproducts
  has_many :reviews
  has_many :orders, through: :orderproducts,
  belongs_to :merchant
end
