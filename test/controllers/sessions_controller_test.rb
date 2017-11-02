require "test_helper"

describe SessionsController do
  let(:merchant) { merchants(:ada) }

  describe "auth_callback" do
    it "logs in an existing merchant and redirects to home path" do
      login(merchant)
      must_redirect_to home_path
      session[:user_id].must_equal  merchant.id
      flash[:result_text].must_include "Welcome back"
    end

    it "does not change merchant count for existing merchant" do
      proc {
        login(merchants(:grace))
      }.wont_change "Merchant.count"
    end

    it "creates a new merchant if you have never logged in before" do
      merchant = Merchant.new(provider: :github, username: 'Ada', email: 'ada@adadev.org', uid: 999)

      login(merchant)
      must_respond_with :redirect
      must_redirect_to home_path

      session[:user_id].must_equal Merchant.last.id
    end

    it "should not create a new merchant on repeat logins" do
      proc {
        3.times do
          login(merchant)
        end
      }.wont_change "Merchant.count"
    end

  end

  describe "logout path" do
    it "logs a user out" do
      merchant = merchants(:grace)
      login(merchant)
      session[:user_id].must_equal  merchant.id

      post logout_path
      must_redirect_to home_path
      session[:user_id].must_equal nil
    end

    it "does not have a user id if you are logged out" do
      merchant = merchants(:ada)
      login(merchant)

      post logout_path
      session[:user_id].must_equal nil
    end
  end
end
