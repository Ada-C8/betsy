require "test_helper"

describe CategoriesController do

  describe "index" do
    it "gets a list of categories" do
      get categories_path
      must_respond_with :success
    end #index

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
end #all tests
## NEED TO ADD FIXTURES !!

  describe "create" do
    it "creates a valid category when data is valid" do
      # test failing because i need to add test data for merchant and category

      # category_data = {
      #   category: {
      #     category_name: "abcdefg"
      #   }
      # }
      start_category_count = Category.count
      # c = Category.new(category_data[:category])
      c = Category.new
      c.category_name = "abcdefg"
      c.must_be :valid?
      c.save

      # # post categories_url, params: { category: { category_name: "ABCDE"} }
      # # must_respond_with 302
      # # must_redirect_to categories_url
      #
      Category.count.must_equal start_category_count + 1
    end #valid data test


    it "will not create a new cateogry when data is invalid" do
      start_category_count = Category.count
      c = Category.new
      c.category_name = ""
      c.wont_be :valid?
      c.save

      #
      # post products_path, params: invalid_product_data
      # must_respond_with :bad_request

      Category.count.must_equal start_category_count
    end

  end #create tests
  # describe "show" do
  #   it "return success when given a valid work id" do
  #     product_id = Product.first.id
  #     get product_path(product_id)
  #     must_respond_with :success
  #   end
  #   it "returns not found when given an invalid product id" do
  #     product_id = Product.first.id + 1
  #     get product_path(product_id)
  #     must_respond_with :not_found
  #   end
  # end
  #
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
# end
