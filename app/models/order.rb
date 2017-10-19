class Order < ApplicationRecord
  belongs_to :merchant, optional: true
  has_many :order_products
  has_many :products, through: :orderproduct
end
