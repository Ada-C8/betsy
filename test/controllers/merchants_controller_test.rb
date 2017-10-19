require "test_helper"

describe MerchantsController do
  describe "index" do
    it "succeeds with many merchants" do
      # Assumption: there are many merchants in the DB
      # @merchants.count.must_be :>, 0
      get merchants_path
      must_respond_with :success
    end

    it "succeeds with no merchants" do
      # Start with a clean slate
      # binding.pry
      Merchant.destroy_all

      get merchants_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "succeeds for an extant merchant" do
      get merchant_path(Merchant.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus merchant" do
      bogus_merchant_id = Merchant.last.id + 1
      # binding.pry
      get merchant_path(bogus_merchant_id)
      must_respond_with :not_found
    end
  end
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end
end
