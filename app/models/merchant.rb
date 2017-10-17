class Merchant < ApplicationRecord
  has_many :reviews
  has_many :products
  has_many :orders
  has_many :orderproducts, through: :orders

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness:true
  validates_format_of :email, :with =>  /\A\S+@.+\.\S+\z/
end
