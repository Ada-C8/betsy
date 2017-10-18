require "test_helper"

describe Product do
  describe "validations" do
    it "requires a name" do
      products(:pointy_hat).merchant = Merchant.first
      products(:pointy_hat).save
      products(:pointy_hat).valid?.must_equal true


      products(:missing_name).valid?.must_equal false

      products(:missing_name).name = "Another pointy hat"
      products(:missing_name).save
      products(:missing_name).valid?.must_equal true
    end

  end
end
