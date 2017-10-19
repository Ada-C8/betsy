require "test_helper"

describe MerchantsController do
  describe "#index" do
    it "should respond with success when there are many merchants" do
      Merchant.count.must_be :>, 0
      get merchants_path
      must_respond_with :success
    end

    it "should succeed with no merchants" do
      Product.destroy_all
      Merchant.destroy_all

      get merchants_path
      must_respond_with :success
    end
  end

  describe "#show" do
    it "should succeed with an existing merchant" do
      get merchant_path(Merchant.first)
      must_respond_with :success
    end
  end
end
