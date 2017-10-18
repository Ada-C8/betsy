require "test_helper"

describe Order do
  describe "relations" do
    it "has a list of products" do
      pending_order = orders(:pending_order)
      pending_order.must_respond_to :products
      pending_order.products.each do |product|
        product.must_be_kind_of Product
      end
    end
    it "has a list of merchants through products" do
      pending_order = orders(:pending_order)
      pending_order.must_respond_to :products
      pending_order.products.each do |product|
        product.merchant.must_be_kind_of Merchant
      end
    end
  end
  describe "validations" do
    it "must have a status to be valid" do
      order_with_stat = orders(:pending_order)
      order_with_stat.valid?.must_equal true

      no_stat_order = orders(:pending_order)
      no_stat_order.status = nil
      no_stat_order.valid?.must_equal false
    end
    it "must have a status equal to pending or complete" do
      order_with_bogus_stat = orders(:pending_order)
      order_with_bogus_stat.status = "almost a status"
      order_with_bogus_stat.valid?.must_equal false
    end
    
  end
end
