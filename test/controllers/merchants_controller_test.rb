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

      # merchant = Merchant.new(username: "angela", email: "fake.email@fake.com")
      #
      # merchant.must_be_instance_of Merchant
    end
  end
end
