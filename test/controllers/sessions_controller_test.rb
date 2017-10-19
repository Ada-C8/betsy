require "test_helper"

describe SessionsController do
  test 'sign in should redirect to root_path' do
  username = username: username
  post '/auth/developer/callback', params: {
    name: merchant.name,
    email: merchant.email
  }
  assert_not_nil @response.cookies[Rails.application.config.session_options[:key]]
  assert_equal merchant.id, session[:current_user_id]
  assert_redirected_to root_path
end

  # describe "login" do
  #   it "allows a new merchant to log in" do
  #     username = "username"
  #
  #     Merchant.find_by(username: username).must_be_nil
  #     # should find no merchant with this username
  #
  #     post login_path, params: { username: username }
  #     # do the actions defined in sessions#create (as defined in routes for login_path) using the information defined in username: username (in this case, username: username)
  #
  #     must_redirect_to root_path
  #   end
  #
  #   it "creates " do
  #     skip
  #   end
  #
  #   it "allows a returning user to log in" do
  #     Merchant.create(username: 'finn', email: 'puppies@kittens.com')
  #     # creates a new merchant in the db
  #     username = Merchant.first.username
  #     # this sets the username as the first existing merchant (that already exists)
  #
  #     post login_path, params: { username: username }
  #     # (same as test one)
  #     # do the actions defined in sessions#create (as defined in routes for login_path) using the information defined in username: username (in this case, a returning user)
  #
  #     must_redirect_to root_path
  #   end
  #
  #   it "renders bad_request if the username entered is blank" do
  #     post login_path, params: { username: "" }
  #
  #     must_respond_with :bad_request
  #   end
  #
  #   it "renders bad_request if a merchant is already logged in" do
  #     skip
  #   end
  # end
  #
  # describe "logout" do
  #   it "succeeds if the user is logged in" do
  #     skip
  #     # Gotta be logged in first
  #     post login_path, params: { username: "test user" }
  #     must_redirect_to root_path
  #
  #     post logout_path
  #     must_redirect_to root_path
  #   end
  #
  #   it "succeeds if the user is not logged in" do
  #     post logout_path
  #     must_redirect_to root_path
  #   end
  # end
end
