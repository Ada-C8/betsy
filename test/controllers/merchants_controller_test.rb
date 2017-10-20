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

  describe "new" do
    it "works" do
      get new_merchant_path
      must_respond_with :success
    end
  end

  describe "create" do

  end

  #
  describe "edit" do
    it "succeeds for an extant merchant ID" do
      get edit_merchant_path(Merchant.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus merchant ID" do
      bogus_merchant_id = Merchant.last.id + 1
      get edit_merchant_path(bogus_merchant_id)
      must_respond_with :not_found
    end
  end

  describe "update" do

    it "returns success if the merchant ID is valid and the change is valid" do
      merchant = Merchant.first
      merchant_data = {
        merchant: {
          username: "changed username",
          email: merchant.email
        }
      }
      merchant.update_attributes(merchant_data[:merchant])
      merchant.must_be :valid?, "Test is invalid because the provided data will produce an invalid merchant"

      patch merchant_path(merchant), params: merchant_data

      must_respond_with :redirect
      must_redirect_to merchant_path(merchant)

      # Check that the change went through
      merchant.reload
      merchant.username.must_equal merchant_data[:merchant][:username]
    end
    #
    it "returns not_found if the merchant ID is invalid" do
      invalid_merchant_id = Merchant.last.id + 1
      merchant_data = {
        merchant: {
          username: "Changed username",
          merchant_id: Merchant.first.id
        }
      }

      patch merchant_path(invalid_merchant_id), params: merchant_data

      must_respond_with :not_found
    end
    #
    it "returns bad_request if the change is invalid" do
      merchant = Merchant.first
      invalid_merchant_data = {
        merchant: {
          email: ""
        }
      }
      # Check that the update is actually invalid
      merchant.update_attributes(invalid_merchant_data[:merchant])
      merchant.wont_be :valid?

      patch merchant_path(merchant), params: invalid_merchant_data

      must_respond_with :bad_request

      merchant.reload
      merchant.username.wont_equal invalid_merchant_data[:merchant][:username]
    end
  end
end
