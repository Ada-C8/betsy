require "test_helper"

describe Order do
  describe "relations" do
    it "has a list of products" do
      pending_order = orders(:pending_order)
      product = products(:pointy_hat)

      pending_order.must_respond_to :products

      pending_order.products << product
      pending_order.products.count.must_equal 1
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

    it "must have all user information if status is complete" do
      complete_order = orders(:complete_order)
      complete_order.valid?.must_equal true

      complete_order.email = nil
      complete_order.valid?.must_equal false
      complete_order.email = "present"
      complete_order.valid?.must_equal false

      complete_order.address = nil
      complete_order.valid?.must_equal false
      complete_order.address = "present"
      complete_order.valid?.must_equal true

      complete_order.name = nil
      complete_order.valid?.must_equal false
      complete_order.name = "present"
      complete_order.valid?.must_equal true

      complete_order.card_number = nil
      complete_order.valid?.must_equal false
      complete_order.card_number = "present"
      complete_order.valid?.must_equal true

      complete_order.card_exp = nil
      complete_order.valid?.must_equal false
      complete_order.card_exp = "present"
      complete_order.valid?.must_equal true

      complete_order.card_cvv = nil
      complete_order.valid?.must_equal false
      complete_order.card_cvv = "present"
      complete_order.valid?.must_equal true

      complete_order.zip_code = nil
      complete_order.valid?.must_equal false
      complete_order.zip_code = "present"
      complete_order.valid?.must_equal true

      pending_order = orders(:pending_order)
      pending_order.valid?.must_equal true
    end
  end
end
