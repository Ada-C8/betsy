require "test_helper"

describe OrderProductsController do
  describe "index" do
    it "returns success for the order products of a specific merchant if given a merchant" do
      merchant = :ada
      get merchant_sold_index_path(merchant)
      must_respond_with :success
    end
  end

  describe "new" do
    it "returns success for a new order product" do
      get new_order_product_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "adds order product to the database and redirects when the data is valid" do
      order_product = {
        order_product: {
          quantity: 2,
          product: :mermaid_fin
        }
      }
      OrderProduct.new(order_product[:order_product]).must_be :valid?
      start_count = OrderProduct.count

      post order_products_path, params: order_product

      must_respond_with :redirect
      must_redirect_to order_products_path
      OrderProduct.count.must_equal start_count + 1
    end

    it "re-renders form when the order product data is invalid" do
      order_product = {
        order_product: {
          quantity: 2
        }
      }
      OrderProduct.new(order_product[:order_product]).wont_be :valid?
      start_count = OrderProduct.count

      post order_products_path, params: order_product

      must_respond_with :bad_request
      OrderProduct.count.must_equal start_count
    end
  end

  describe "show" do
    it "returns success with valid id" do
      order_product_id = OrderProduct.first.id
      get order_product_path(order_product_id)
      must_respond_with :success
    end

    it "returns not_found with invalid id" do
      invalid_id = OrderProduct.last.id + 1
      get order_product_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "returns success with valid id" do
      order_product_id = OrderProduct.first.id
      get edit_order_product_path(order_product_id)
      must_respond_with :success
    end

    it "returns not_found with invalid id" do
      invalid_id = OrderProduct.last.id + 1
      get edit_order_product_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "returns success if order product exists and changes are valid" do
      order_product = OrderProduct.first
      changes = {
        order_product: {
          quantity: 2
        }
      }
      order_product.update_attributes(changes[:order_product])
      order_product.must_be :valid?

      patch order_product_path(order_product), params: changes
      must_respond_with :redirect
      must_redirect_to order_product_path(order_product)

      order_product.reload
      order_product.quantity.must_equal changes[:order_product][:quantity]
    end

    it "returns not_found if work does not exist" do
      order_product = OrderProduct.first
      changes = {
        order_product: {
          quantity: 2
        }
      }
      order_product.update_attributes(changes[:order_product])
      order_product.must_be :valid?
      order_product.destroy

      patch order_product_path(order_product), params: changes
      must_respond_with :not_found
    end
  end

  describe "destroy" do
    it "returns success and destroys if work exists" do
      order_product = OrderProduct.first
      order_product.must_be :valid?
      delete order_product_path(order_product)
      must_respond_with :redirect
      must_redirect_to order_products_path
    end

    it "returns not_found if work does not exist" do
      order_product = OrderProduct.first
      order_product.must_be :valid?
      delete order_product_path(order_product)
      delete order_product_path(order_product)
      must_respond_with :not_found
    end
  end
end
