class Merchant < ApplicationRecord
  has_many :reviews
  has_many :products
  has_many :orders
  has_many :order_products, through: :orders

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness:true
  validates_format_of :email, :with =>  /\A\w+@\w+\.\w+\z/
  validates :oauth_provider, presence: true
  validates :oauth_uid, presence: true, uniqueness: true
end
