require "test_helper"

describe MerchantsController do

  describe "show" do
    it "succeeds for an extant merchant" do
      get merchant_path(Merchant.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus merchant" do
      bogus_merchant_id = Merchant.last.id + 1
      get merchant_path(bogus_merchant_id)
      must_respond_with :not_found
    end
  end

  describe "login" do
    it "should generate success if logged in" do
      auth_hash = {
        provider:"github",
        uid: "9999999999",
        email: "somebodnew@somesite.com",
        username: "Somebodynew"
      }

      get login_path(auth_hash)
      must_respond_with :found
      must_redirect_to root_path
      flash[:status].must_equal :success
      flash[:result_text].must_equal "Successfully logged in "
    end
    
    it "logs in an existing merchant and redirects to the root route" do

      start_count = Merchant.count

      merchant = merchants(:grace)
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(merchant))

      get login_path(:github)

      must_redirect_to root_path

      session[:merchant][:id].must_equal merchant.id

      Merchant.count.must_equal start_count
    end
    # session[:merchant].must_be_nil
    # flash[:status].must_equal :failure
    # flash[:result_text].must_equal "Not logged in"
    # flash[:messages].must_include :email
    # flash[:messages].must_include :username
    #   must_respond_with :failure
    #   must_redirect_to root_path
    # binding.pry
    # end

  end

  describe "logout" do
    it "logs merchants out" do
      get logout_path
      session[:merchant].must_equal nil
      must_redirect_to root_path
    end
  end

  describe "create" do
    it "works" do
      merchant = {
        merchant: {
          oauth_provider: "github",
          oauth_uid: "99999",
          email: "somebody@somesite.com",
          username: "Somebody"
        }
      }
      Merchant.new(merchant[:merchant]).must_be :valid?
      start_count = Merchant.count
      post merchants_path, params: merchant
      flash[:status].must_equal :success
      flash[:message].must_include "Successfully created merchant"
      must_respond_with :redirect
      must_redirect_to root_path
      Merchant.count.must_equal start_count + 1
    end


    it "re-renders form when the merchant data is invalid" do
      merchant = {
        merchant: {
          oauth_provider: "github",
          oauth_uid: "",
          email: "somebodyelse@somesite.com",
          username: "Somebody_else"
        }
      }
      Merchant.new(merchant[:merchant]).wont_be :valid?
      start_count = Merchant.count

      post merchants_path, params: merchant

      must_respond_with :bad_request
      Merchant.count.must_equal start_count
    end
  end

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
  describe "destroy" do
    it "removes the merchant and goes to the root path" do
      first_count = Merchant.all.count
      Merchant.first.destroy
      # must_redirect_to root_path
      Merchant.all.count.must_equal first_count - 1

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
