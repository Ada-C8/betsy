require "test_helper"

describe MerchantsController do
  describe "#index" do
    it "should respond with success when there are many merchants" do
      Merchant.count.must_be :>, 0
      get merchants_path
      must_respond_with :success
    end

    it "should succeed with no users" do
      Product.destroy_all
      Merchant.destroy_all

      get merchants_path
      must_respond_with :success
    end
  end

  describe "#new" do
    it "merchants" do
      get new_merchant_path
      must_respond_with :success
    end
  end

  describe "#create" do
    it "creates a merchant with "
  end
end
