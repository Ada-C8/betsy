require "test_helper"

describe ProductsController do

  describe "index" do
    it "gets a list of products" do
      get products_path
      must_respond_with :success
    end

    it "returns a success status when no products" do
      Product.destroy_all
      get products_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "returns a success status" do
      get new_product_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "redirects to products_path when product data is valid" do
      product_data = {
        product: {
          name: "test product",
          price: 12
        }
      }
      Product.new(product_data[:product]).must_be :valid?

      start_product_count = Product.count

      post products_path, params: product_data
      must_respond_with :redirect
      must_redirect_to products_path

      Product.count.must_equal start_product_count + 1
    end

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
    end
  end

end
