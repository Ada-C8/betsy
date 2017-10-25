class Merchant < ApplicationRecord
  has_many :reviews
  has_many :products
  has_many :orders
  has_many :order_products, through: :orders

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness:true
  validates_format_of :email, :with =>  /\A[\w|.|+]+@[\w|.|+]+\.[\w|.|+]+\z/
  validates :oauth_provider, presence: true
  validates :oauth_uid, presence: true, uniqueness: true

  def self.by_auth_hash(auth_hash)
    merchant = Merchant.new

    merchant.oauth_provider = auth_hash['provider']
    merchant.oauth_uid = auth_hash['uid']
    merchant.email = auth_hash['info']['email']
    merchant.username = auth_hash['info']['nickname']

    merchant
  end

  def own_orders
    OrderProduct.all.find_all {|op| op.product.merchant_id == id && op.order != nil}
  end

  def pending_orders
    own_orders.find_all { |o| o.status == "pending" }
  end

  def shipped_orders
    own_orders.find_all { |o| o.status == "shipped" }
  end

  def total_revenue
    shipped_orders.sum { |o| o.total }
  end

  def active_products
    products.find_all { |p| p.quantity > 0 }
  end

  def inactive_products
    products.find_all { |p| p.quantity == 0 }
  end
end
