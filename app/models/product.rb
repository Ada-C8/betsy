class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity_avail, presence: true, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :merchant
  has_many :reviews
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :orders

  def remove_one_from_stock
    if self.quantity_avail > 0
    #   order = Order.find_by(id: session[:order_id])
    #     order.products << self
        self.quantity_avail -= 1
        self.save
    else
      flash[:error] = "product is not available"
    end
  end

end
