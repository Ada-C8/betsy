require "test_helper"

describe OrderProductsController do
  describe "index" do
    it "returns success for the order products of a specific merchant if given a merchant" do
      merchant = :ada
      get merchant_sold_index_path(merchant)
      must_respond_with :success
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
      must_redirect_to shopping_cart_path

      order_product.reload
      order_product.quantity.must_equal changes[:order_product][:quantity]
    end

    it "returns failure if order product exists and changes are invalid" do
      order_product = OrderProduct.first
      changes = {
        order_product: {
          quantity: 900000
        }
      }
      patch order_product_path(order_product), params: changes
      order_product.quantity.wont_equal 900000
    end

    it "returns not_found if order product does not exist" do
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
    it "returns success and destroys if order product exists" do
      order_product = OrderProduct.first
      order_product.must_be :valid?
      delete order_product_path(order_product)
      must_respond_with :redirect
      must_redirect_to shopping_cart_path
    end

    it "returns not_found if order product does not exist" do
      order_product = OrderProduct.first
      order_product.must_be :valid?
      delete order_product_path(order_product)
      delete order_product_path(order_product)
      must_respond_with :not_found
    end
  end
end
