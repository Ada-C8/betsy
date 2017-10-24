require "test_helper"

describe OrdersProductsController do
  describe "associations" do
    it "responds to order" do
      order_product = OrderProduct.new
      order_product.must_respond_to :order
    end
    it "responds to product" do
      order_product = OrderProduct.new
      order_product.must_respond_to :product
    end
  end
end
