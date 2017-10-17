class Merchant < ApplicationRecord
  has_many :reviews
  has_many :products
  has_many :orders
  has_many :orderproducts, through: :orders

end
