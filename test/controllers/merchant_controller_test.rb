require "test_helper"

describe MerchantController do
  describe "index" do
    it "renders page with all merchants" do
      get merchants_path
      must_respond_with :success
    end

    it "makes new merchant" do
      get new_merchant_path
      must_respond_with :success
    end
  end #end index
end
