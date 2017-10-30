require "test_helper"

describe CategoriesController do
  describe "when user is logged in" do

    before do
      login(users(:tanja))
    end

    it "should show the new form" do
      get new_category_path
      must_respond_with :success
    end

    it "after create, redirects" do
      post categories_path, params: { category: {name: "funky"}}
      must_respond_with :redirect
      must_redirect_to user_account_path(users(:tanja).id)
    end

    it " Data should reflect newly created category" do
      proc {
        post categories_path, params: { category: {name: "some cat"}}
      }.must_change 'Category.count', 1
    end


    it " Should render template and not affect the data if failed " do
      proc {
        post categories_path, params: { category: {name: ""}}
      }
    end
  end

  describe "when user is not logged in" do

    it " should redirect if user not logged in " do
      get new_category_path
      must_respond_with :redirect
    end

  end
end
