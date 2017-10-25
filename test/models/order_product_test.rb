require "test_helper"

describe OrderProduct do
  let(:order_product) { order_products(:one)}

  describe "validations" do
    describe "quantity" do
      it "should return false without a quantity" do
        order_product.valid?.must_equal true
        order_product.quantity = nil
        order_product.valid?.must_equal false
      end

      it "should return false if quantity is not greater than 0 " do
        order_product.quantity = 0
        order_product.valid?.must_equal false
      end
    end
  end

  describe "relationships" do
    it "has a product" do
      b = order_products(:one)
      a = products(:mermaid_fin)

      b.must_respond_to :product
      b.product.must_equal a
      b.product_id.must_equal a.id
    end

    it "has an order" do
      b = order_products(:one)
      a = orders(:order)

      b.must_respond_to :order
      b.order.must_equal a
      b.order_id.must_equal a.id
    end
  end
end
