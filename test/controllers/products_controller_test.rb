require "test_helper"

describe ProductsController do

  describe "index" do
    it "gets a list of products" do
      get products_path
      must_respond_with :success
    end #get list

    it "returns a success status when no products" do
      Product.destroy_all
      get products_path
      must_respond_with :success
    end #no products
  end #index tests

  describe "new" do
    it "returns a success status" do
      get new_product_path
      must_respond_with :success
    end #succes
  end #new tests

  ## NEED TO ADD FIXTURES !!

  describe "create" do
    it "redirects to products_path when product data is valid" do
      # test failing because i need to add test data for merchant and category

      valid_product_data = {
        product: {
          name: "test product",
          stock: 10,
          price: 12,
          merchant_id: merchants(:fake_user).id,
          category_id: categories(:cat_one).id
        }
      }
      start_product_count = Product.count

      Product.new(valid_product_data[:product]).must_be :valid?

      post products_path, params: valid_product_data
      must_respond_with :redirect
      must_redirect_to products_path

      Product.count.must_equal start_product_count + 1
    end #create when data is valid

    it "sends bad request when product data is invalid" do
      invalid_product_data = {
        product: {
          name: "",
          price: "12"
        }
      }
      Product.new(invalid_product_data[:product]).wont_be :valid?

      start_product_count = Product.count

      post products_path, params: invalid_product_data
      must_respond_with :bad_request

      Product.count.must_equal start_product_count
    end #create when data is not valid
  end #create tests


  describe "show" do
    it "return success when given a valid product id" do
      product_id = Product.first.id
      get product_path(product_id)
      must_respond_with :success
    end

    it "returns not found when given an invalid product id" do
      product_id = Product.last.id + 1
      get product_path(product_id)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "returns success when given a valid product id" do
      product_id = Product.first.id
      get edit_product_path(product_id)
      must_respond_with :success
    end #edit success

    it "returns not found when given an invalid product id" do
      invalid_product_id = Product.last.id + 1
      get edit_product_path(invalid_product_id)
      must_respond_with :not_found
    end #edit failure
  end #all edit

  describe "destroy" do
    it "returns success and destroys the book when given a valid book ID" do
      # Arrange
      product_id = Product.last.id
      @product = Product.find_by(id: product_id)
      # Act
      delete product_path(product_id)

      # Assert
      must_respond_with :redirect
      must_redirect_to root_path
      @product.must_be_nil
    end #success

    it "returns not_found when given an invalid book ID" do
      invalid_product_id = Product.last.id + 1

      start_product_count = Product.count

      delete product_path(invalid_product_id)

      must_respond_with :not_found
      Product.count.must_equal start_product_count
    end #not foudn
  end #destroy
  #
  # describe "destroy" do
  #   it "it destroys an existing product and redirects" do
  #     valid_product_id = Product.last.id
  #     delete product_path(valid_product_id)
  #     #get product_path(product_id)
  #     must_respond_with :redirect
  #     must_redirect_to root_path
  #     Product.find_by(id: valid_product_id).must_be_nil
  #   end #exists
  #
  #   it "returns not found when given an invalid ID" do
  #     invalid_product_id = Product.last.id + 1
  #     start_product_count = Product.count
  #     delete product_path(invalid_product_id)
  #     must_respond_with :not_found
  #     Product.count.must_equal start_product_count
  #   end #doesn't exist
  # end #all destroy



end #all tests
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
