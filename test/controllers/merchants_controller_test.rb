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

    it "renders 404 not_found when you try to show an invalid merchant" do
      bad = Merchant.last.id + 1
      get merchant_path(bad)
      must_respond_with :not_found
    end
  end

  describe "#new" do
    it "should successfully get new page" do
      get new_merchant_path
      must_respond_with :success
    end
  end

  # describe "edit" do
  #   it "succeeds for an existing merchant" do
  #     get edit_merchant_path(Merchant.first)
  #     must_respond_with :success
  #   end
  #
  #   it "returns an error for a non-existant ID" do
  #     # no_merchant_id = Merchant.last.id + 1
  #     get edit_merchant_path(100)
  #     must_respond_with :failure
  #   end
  # end
  #
  # describe "update" do
  #   it "succeeds for valid data and an existing ID" do
  #     merchant = Merchant.first
  #     merchant_data = {
  #       merchant: {
  #         email: merchant.email + " addition"
  #       }
  #     }
  #
  #     patch merchant_path(merchant), params: merchant_data
  #     must_redirect_to merchant_path(merchant)
  #
  #     Merchant.find(merchant.id).email.must_equal merchant_data[:merchant][:email]
  #   end
  #
  #   it "renders the form for bad data" do
  #     merchant = Merchant.first
  #     merchant_data = {
  #       merchant: {
  #         email: ""
  #       }
  #     }
  #
  #     patch merchant_path(merchant), params: merchant_data
  #     must_respond_with :success
  #
  #     Merchant.find(merchant.id).email.must_equal merchant.email
  #   end
  # end
  #
  # describe "destroy" do
  #   it "succeeds for an existing id" do
  #     # merchant_id = Merchant.first.id
  #     #
  #     # delete merchant_path(merchant_id)
  #     # must_redirect_to root_path
  #
  #     delete merchant_path(merchants(:ghosty).id)
  #     must_respond_with :redirect
  #     must_redirect_to root_path
  #
  #     Merchant.find_by(id: merchants(:ghosty)).must_be_nil
  #   end
  # end

  describe "when authenticated" do
    let(:merchant) { merchants(:ada) }

    it "should allow a merchant to view its own orders page" do
      merchant = merchants(:ada)
      login(merchant)
      get merchant_orders_path(merchants(:ada).id)
      must_respond_with :success
    end

    it "should not allow merchants to view other merchants orders page" do
      merchant = merchants(:ada)
      login(merchant)
      get merchant_orders_path(merchants(:spooky).id)
      must_respond_with :redirect
      must_redirect_to home_path
      flash.keys.must_include "result_text"
    end
  end
end
