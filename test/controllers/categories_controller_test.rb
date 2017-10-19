require "test_helper"

describe CategoriesController do
  it "should successfully get to categorys index page" do
    get categories_path
    must_respond_with :success
  end

  it "should successfully get to category show page" do
    get category_path(categories(:brooms).id)
    must_respond_with :success
  end

  it "should successfully get new page" do
    get new_category_path
    must_respond_with :success
  end

  it "should be able to create a new category" do
    post categories_path, params: {category: {name: "creepy things"}}
    must_respond_with :redirect
    must_redirect_to categories_path

    proc   {
      post categories_path, params: {category: {name: "creepy things"}}
    }.must_change 'Category.count', 1
  end

  it "should successfully delete category" do
    delete category_path(categories(:brooms).id)
    must_respond_with :redirect
    must_redirect_to categories_path

    proc   {
      delete category_path(categories(:brooms).id)
    }.must_change 'Category.count', -1
  end
end
