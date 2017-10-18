require "test_helper"

describe MerchantController do
  describe "index" do
    it "renders page with all merchants" do
      get merchants_path
      must_respond_with :success
    end
  end
end
