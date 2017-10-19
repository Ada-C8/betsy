require "test_helper"

describe MerchantsController do
  describe "index" do
    it "renders page with all merchants" do
      get merchants_path
      must_respond_with :success
    end

    it "success with their are no merchants" do
      Merchant.destroy_all

      get merchants_path
      must_respond_with :success
    end
  end #end index

  describe "new" do
    it "Successfully makes a new merchant" do
      get new_merchant_path
      must_respond_with :success
    end
  end # end new

  describe "show" do
    it "success for vaild merchant ID" do
      get merchant_path(Merchant.first)
      must_respond_with :success
    end

    it "gives 404 erroe page for bogus merchant ID" do
      bogus_merchant = Merchant.last.id + 1

      get merchant_path(bogus_merchant)
      must_respond_with :not_found

    end
  end # end show

  describe "edit" do
    it "successfully edits a valid merchant" do

      merchant = Merchant.first
      #what is the context (can be variable)
      #what are we testing (methods,etc.)

      # what is result we expect



    end
  end
end
