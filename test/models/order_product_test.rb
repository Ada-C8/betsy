require "test_helper"

describe OrderProduct do
  let(:order_product) { OrderProduct.new }

  describe "associations" do
    it "responds to order" do
      order_product = order_products(:one)
      order_product.must_respond_to :order
    end
    it "responds to order" do
      order_product = order_products(:one)
      order_product.must_respond_to :product
    end
  end

end
