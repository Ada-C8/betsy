class Order < ApplicationRecord
  belongs_to :merchant, optional: true
  has_many :orderproducts
  has_many :products, through: :orderproduct
end
