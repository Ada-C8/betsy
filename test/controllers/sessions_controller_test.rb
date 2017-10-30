require "test_helper"

describe SessionsController do

  describe "auth_callback" do
    it "logs in an existing user and redirects to the root route" do
      # Count the users, to make sure we're not (for example) creating
      # a new user every time we get a login request
      start_count = User.count

      login(users(:amy))
      must_redirect_to root_path

      # Since we can read the session, check that the user ID was set as expected
      session[:user_id].must_equal users(:amy).id

      # Should *not* have created a new user
      User.count.must_equal start_count
    end

    it "should not create a new user on repeated logins" do

      proc{
        3.times do
          login(users(:amy))
        end
      }.wont_change "User.count"

    end

    it "logged in user has a name" do
      amy = users(:amy)
      login(amy)
      amy.name.must_equal "Amy Lee"

    end

    it "logged in user has an email address" do
      amy = users(:amy)
      login(amy)
      amy.email.must_equal "amy@ada.com"
    end

    it "creates an account for a new user and redirects to the root route" do

      start_count = User.count
      user = User.new(provider: "github", uid: 99999, name: "test_user", email: "test@user.com")

      login(user)
      must_redirect_to root_path

      # Should have created a new user
      User.count.must_equal start_count + 1

      # The new user's ID should be set in the session
      session[:user_id].must_equal User.last.id
    end

    it "responds with bad request if given invalid user data" do

      start_count = User.count
      user = User.new(uid: 99999, name: "test_user", email: "test@user.com")

      login(user)
      must_respond_with :bad_request
      User.count.must_equal start_count

    end

    it "successfully logs out a user" do
      login(users(:amy))
      post logout_path
      must_redirect_to root_path
      flash[:result_text].must_equal "Successfully logged out"
      session[:user_id].must_be_nil
    end

  end
end
