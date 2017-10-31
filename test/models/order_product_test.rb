require "test_helper"

describe OrderProduct do

  before do
    @order_product = order_products(:op_four)
  end

  describe "associations" do
    it "responds to order" do
      @order_product.must_respond_to :order
    end

    it "responds to order" do
      @order_product.must_respond_to :product
    end
  end

end
