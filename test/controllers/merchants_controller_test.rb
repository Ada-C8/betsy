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

    it "logs in an existing merchant and redirects to the root route" do
      start_count = Merchant.all.count

      merchant = merchants(:grace)
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(merchant))

      get login_path(:github)

      must_redirect_to root_path

      session[:merchant][:id].must_equal merchant.id

      Merchant.all.count.must_equal start_count
    end

    it "creates new user with new info" do

      start_count = Merchant.all.count
      new_merchant = Merchant.new(oauth_provider: 'github',oauth_uid: "adlgkcl",email: 'mail@mail.com', username: 'Mr. New')
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(new_merchant))
      get login_path(:github)
      must_redirect_to root_path
      Merchant.count.must_equal start_count + 1
      session[:merchant][:id].must_equal Merchant.last.id
      flash[:result_text].must_equal "Successfully created new merchant "
      flash[:status].must_equal :success

    end

    it "generates failure with no info" do
      start_count = Merchant.all.count
      OmniAuth.config.mock_auth[:github] = nil
      get login_path(:github)
      Merchant.count.must_equal start_count
      flash[:result_text].must_equal "Not logged in"
      flash[:status].must_equal :failure
      flash[:messages].must_include :email
      flash[:messages].must_include :username
      must_redirect_to root_path
    end

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
      delete_merchant = Merchant.first
      delete merchant_path(delete_merchant)
      must_respond_with :redirect
      must_redirect_to root_path
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

  describe "user pages" do
    describe "logged in" do
      before do
        user = merchants(:ada)
        OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))
        get login_path(:github)
      end

      it 'logged in user can access summary' do
        get self_summary_path

        must_respond_with :success
      end

      it 'logged in user can access pending' do
        get self_pending_path

        must_respond_with :success
      end

      it 'logged in user can access completed' do
        get self_completed_path

        must_respond_with :success
      end

      it 'logged in user can access revenue' do
        get self_summary_path

        must_respond_with :success
      end

      it 'logged in user can access inventory' do
        get self_summary_path

        must_respond_with :success
      end

      describe 'mark_shipped' do
        it 'changes the status of an existing product owned by the user' do
          op_id = order_products(:order_products).id
          get mark_shipped_path(op_id)

          must_respond_with :found
          flash[:status].must_equal :success
          OrderProduct.find(op_id).status.must_equal "shipped"
        end

        it 'returns not_found if product does not exist' do
          get mark_shipped_path(OrderProduct.last.id + 1)

          must_respond_with :not_found
        end

        it 'redirects without changing if product does not belong to user' do
          op_id = order_products(:other_order_products).id
          get mark_shipped_path(op_id)

          must_respond_with :found
          flash[:status].must_equal :failure
          OrderProduct.find(op_id).status.wont_equal "shipped"
        end
      end
    end

    describe "guests" do
      it 'guest user cannot access summary' do
        get self_summary_path

        must_respond_with :found
      end

      it 'guest user cannot access pending' do
        get self_pending_path

        must_respond_with :found
      end

      it 'guest user cannot access completed' do
        get self_completed_path

        must_respond_with :found
      end

      it 'guest user cannot access revenue' do
        get self_summary_path

        must_respond_with :found
      end

      it 'guest user cannot access inventory' do
        get self_summary_path

        must_respond_with :found
      end

      it 'guest user cannot access mark_shipped' do
        op_id = order_products(:order_products).id
        get mark_shipped_path(op_id)

        must_respond_with :found
        flash[:status].must_equal :failure
        OrderProduct.find(op_id).status.wont_equal "shipped"
      end
    end
  end
end
