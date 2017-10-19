require "test_helper"

describe CategoriesController do
  it "should successfully get to categories index page" do
    get categories_path
    must_respond_with :success
  end

  it "succeeds when there are no categories" do
    Category.destroy_all
    get categories_path
    must_respond_with :success
  end

  it "should successfully get to category show page" do
    get category_path(categories(:brooms).id)
    must_respond_with :success
  end

  it "renders 404 not_found when you try to show an invalid category " do
    bad = Category.last.id + 1
    get category_path(bad)
    must_respond_with :not_found
  end

  it "should successfully get new page" do
    get new_category_path
    must_respond_with :success
  end

  it "should be able to create a new category" do
    post categories_path, params: {category: {name: "creepy things"}}
    must_respond_with :redirect
    must_redirect_to category_path(Category.last.id)

    proc   {
      post categories_path, params: {category: {name: "other creepy things"}}
    }.must_change 'Category.count', 1
  end

  it "should successfully delete category" do
    delete category_path(categories(:brooms).id)
    must_respond_with :redirect
    must_redirect_to categories_path

    proc   {
      delete category_path(categories(:cauldrons).id)
    }.must_change 'Category.count', -1
  end

  it "renders 404 not_found and does not update the DB for a bogus category ID" do
    start_count = Category.count

    bad = Category.last.id + 1
    delete category_path(bad)
    must_respond_with :not_found

    Category.count.must_equal start_count
  end
end
