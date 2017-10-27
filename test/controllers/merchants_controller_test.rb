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

  describe "#create" do
    it "should be able to create a new merchant" do
      post merchants_path, params: {merchant: {username: "witch0909", email: "witch@witches.com"}}
      must_respond_with :redirect
      must_redirect_to merchant_path(Merchant.last.id)

      proc   {
        post merchants_path, params: {merchant: {username: "witch9999", email: "witchywitch@witches.com"}}
      }.must_change 'Merchant.count', 1
    end
  end

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

  # describe "#destroy" do
  #   it "should successfully delete merchant" do
  #     delete merchant_path(merchants(:spooky).id)
  #     must_respond_with :redirect
  #     must_redirect_to merchants_path
  #
  #     proc   {
  #       delete merchant_path(merchants(:witch).id)
  #     }.must_change 'Merchant.count', -1
  #   end
  #
  #   it "renders 404 not_found and does not update the DB for a bogus merchant ID" do
  #     start_count = Merchant.count
  #
  #     bad = Merchant.last.id + 1
  #     delete merchant_path(bad)
  #     must_respond_with :not_found
  #
  #     Merchant.count.must_equal start_count
  #   end
  # end
end
