require "test_helper"

describe UsersController do

  let(:user) {users(:amy)}

  it "Users#Account" do
    login(user)
    get user_account_path(user.id)
    must_respond_with :success
  end

  describe "OrderFulfillment Page" do
    let (:buttercup) {users(:buttercup)}

    it "shows a user's order fulfillment page " do
      login(buttercup)

      get user_orders_path(buttercup.id)

      must_respond_with :success
    end

    it "renders 404 if user does not exist" do
      nonexistant_id = (User.last.id) + 1

      get user_orders_path(nonexistant_id)
      must_respond_with :not_found

    end

    it "only allows a user to see their order fulfillment page if they are logged in" do

    end

    it "does not allow a user to see the order fulfillment page of a different user" do

    end



  end

end
