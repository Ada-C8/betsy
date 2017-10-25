require "test_helper"
require 'pry'

describe CategoriesController do

  describe "index" do
    it "gets a list of categories" do
      get categories_path
      must_respond_with :success
    end #gets list of categories

    it "returns a success status when no categories" do
      Category.destroy_all
      get categories_path
      must_respond_with :success
    end #no categories
  end #index tests

  describe "new" do
    it "returns a success status" do
      get new_category_path
      must_respond_with :success
    end #return success
  end #new tests

  ## NEED TO ADD FIXTURES !!

  describe "create" do
    it "creates a valid category when data is valid" do

      category_data = {
        category: {
          category_name: "abcdefg"
        }
      }

      start_category_count = Category.count
      Category.new(category_data[:category]).must_be :valid?

      post categories_path, params: category_data

      must_respond_with :redirect
      must_redirect_to categories_path

      Category.count.must_equal start_category_count + 1

    end #valid data test


    it "will not create a new cateogry when data is invalid" do
      invalid_category_data = {
        category: {
          category_name: ""
        }
      }
      start_category_count = Category.count

      Category.new(invalid_category_data[:category]).wont_be :valid?

      post categories_path, params: invalid_category_data
      must_respond_with :bad_request

      Category.count.must_equal start_category_count
    end #invalid data test
  end #create tests


  describe "show" do
    it "should get show" do
      get category_path(categories(:cat_one).id)
      must_respond_with :success
    end #get show

    it "return success when given a valid category id" do
      category_id = Category.first.id
      get category_path(category_id)
      must_respond_with :success
    end #return success

    it "returns not found when given an invalid product id" do
      category_id = Category.last.id + 1
      get category_path(category_id)
      must_respond_with :not_found
    end #return not found
  end #return show


  describe "edit" do
    it "returns success when given a valid category id" do
      # category_id = Category.first.id
      # get edit_category_path(category_id)
      get edit_category_path(categories(:cat_one).id)
      must_respond_with :success
    end #success for edit

    it "returns not found when given an invalid cateogry id" do
      invalid_category_id = Category.last.id + 1
      get edit_category_path(invalid_category_id)
      must_respond_with :not_found
    end #not found when not found
  end #all edit tests

describe "update" do
  it "returns success if category id is valid and change is valid" do
    category = Category.first

    category_data = {
      category: {
        category_name: "Test"
      }
    }

    category.update_attributes(category_data[:category])
    category.must_be :valid?
    patch category_path(category), params: category_data
  end #return success on valid change

  it "returns not found if the work id is invalid" do
    category_id = Category.last.id + 1
    get category_path(category_id)
    must_respond_with :not_found
  end #returns not found if work is invalid
end #update tests

describe "destroy" do
  it "will destory a category if it exists" do
    category_id = Category.first.id
    get category_path(category_id)
    must_respond_with :success
  end

  it "does not exist" do
    product_id = Product.first.id
    delete product_path(product_id)
    must_respond_with :redirect
  end
end
end #all tests
