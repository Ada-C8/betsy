class Merchant < ApplicationRecord
  has_many :products

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true

  def join_orderitems(status)
    if [nil, ""].include?(status)
      return Orderitem.joins('join products on orderitems.product_id = products.id').where("products.merchant_id = #{self.id}")
    else
      return Orderitem.joins('join products on orderitems.product_id = products.id').where("products.merchant_id = #{self.id}").joins('LEFT JOIN orders ON orderitems.order_id = orders.id').where("orders.status = '#{status}'")
    end
  end
end
