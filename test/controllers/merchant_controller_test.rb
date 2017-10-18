require "test_helper"

describe MerchantController do
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
      
    end
  end
end
