require "test_helper"

describe Product do
  describe "validations" do
    it "requires a name" do
      products(:pointy_hat).merchant = Merchant.first
      products(:pointy_hat).save
      products(:pointy_hat).valid?.must_equal true


      products(:missing_name).merchant = Merchant.first
      products(:missing_name).save
      products(:missing_name).valid?.must_equal false

      products(:missing_name).name = "Another pointy hat"
      products(:missing_name).save
      products(:missing_name).valid?.must_equal true
    end

    it "requires a price" do
      test = Product.new(name: "Caldroun", quantity_avail: 1, merchant: Merchant.first)
      test.valid?.must_equal false

      test.price = 59.99
      test.valid?.must_equal true
    end

    it "requires a quantity_avail" do
      test = Product.new(name: "Caldroun", price: 68.50, merchant: Merchant.first)
      test.valid?.must_equal false

      test.quantity_avail = 1
      test.valid?.must_equal true
    end

    it "requires a quantity_avail" do
      test = Product.new(name: "Caldroun", price: 68.50, merchant: Merchant.first)
      test.valid?.must_equal false

      test.quantity_avail = 1
      test.valid?.must_equal true
    end

  end
end
