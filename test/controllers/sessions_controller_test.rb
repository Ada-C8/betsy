require "test_helper"

describe SessionsController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "login" do
    it "allows a new merchant to log in" do
      username = "new_test_user"

      Merchant.find_by(username: username).must_be_nil
      # should find no merchant with this username

      post login_path, params: { username: username }
      # do the actions defined in sessions#create using the information defined in username: username (in this case, username: new_test_user)

      must_redirect_to root_path
    end

    it "succeeds for a returning user" do
      skip
      username = Merchant.first.username
      post login_path, params: { username: username }
      must_redirect_to root_path
    end

    it "renders 400 bad_request if the username is blank" do
      skip
      post login_path, params: { username: "" }
      must_respond_with :bad_request
    end

    it "succeeds if a different user is already logged in" do
      skip
      username = "user_1"
      post login_path, params: { username: username }
      must_redirect_to root_path

      username = "user_2"
      post login_path, params: { username: username }
      must_redirect_to root_path
    end
  end

  describe "logout" do
    it "succeeds if the user is logged in" do
      # Gotta be logged in first
      post login_path, params: { username: "test user" }
      must_redirect_to root_path

      post logout_path
      must_redirect_to root_path
    end

    it "succeeds if the user is not logged in" do
      skip
      post logout_path
      must_redirect_to root_path
    end
  end
end
