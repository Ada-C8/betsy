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

      # Act
      post categories_path, params: category_data

      # Assert
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
        # start_category_count = Category.count
        # c = Category.new
        # c.category_name = ""
        # c.wont_be :valid?
        # c.save
        #
        # Category.count.must_equal start_category_count
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
        get category_path(3)
        must_respond_with :not_found
      end #return not found
    end #return show
  end #all tests
  # describe "edit" do
  #   it "returns success when given a valid product id" do
  #     product_id = Product.first.id
  #     get edit_product_path(product_id)
  #     must_respond_with :success
  #   end
  #   it "returns not found when given an invalid product id" do
  #     invalid_product_id = Product.first.id + 1
  #     get edit_product_path(invalid_product_id)
  #     must_respond_with :not_found
  #   end
  # end
  # #
  # describe "update" do
  #   it "returns success if product id valid and change is valid" do
  #     product = Work.first
  #     product_data = {
  #       product: {
  #         name: "different test",
  #         price: 13
  #       }
  #     }
  #     product.update_attributes(product_data[product])
  #     product.must_be :valid?
  #
  #     patch product_path(product), params: product_data
  #   end
  #   it "returns not found if the work id is invalid" do
  #     product_id = Product.first.id + 1
  #     get product_path(product_id)
  #     must_respond_with :not_found
  #   end
  #
  # end
  # describe "destroy" do
  #   it "exist" do
  #     product_id = Product.first.id
  #     get product_path(product_id)
  #     must_respond_with :success
  #   end
  #   it "does not exist" do
  #     product_id = Product.first.id
  #     delete product_path(product_id)
  #     must_respond_with :redirect
  #   end
  # end
