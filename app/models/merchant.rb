class Merchant < ApplicationRecord
  has_many :products, dependent: :destroy

  has_many :order_products, through: :products
  has_many :orders, through: :order_products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  # provider and uid are validated in the migration

  def self.from_auth_hash(provider, auth_hash)
    merchant = new
    merchant.provider = provider
    merchant.uid = auth_hash['uid']
    merchant.username = auth_hash['info']['name']
    merchant.email = auth_hash['info']['email']

    return merchant
  end
end
