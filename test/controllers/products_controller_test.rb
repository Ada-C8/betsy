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

## NEED TO ADD FIXTURES !!

  describe "create" do
    it "redirects to products_path when product data is valid" do
      # test failing because i need to add test data for merchant and category

      product_data = {
        product: {
          name: "test product",
          price: 12,
          merchant_id: Merchant.first.id,
          category_id: Category.first.id
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
end
