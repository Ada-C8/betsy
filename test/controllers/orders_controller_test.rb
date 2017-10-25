require "test_helper"

describe OrdersController do
  describe "index" do
    it "returns success for the orders of a specific merchant if given a merchant" do
      merchant = :ada
      login_test_user
      get merchant_orders_path(merchant)
      must_respond_with :success
    end
  end

  describe "new" do
    it "returns success for a new orders" do
      get new_order_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "adds order to the database and redirects when the data is valid" do
      order = {
        order: {
          cust_name: "Mermaid",
          merchant_id: 21,
          cust_cc: 12345,
          cust_cc_exp: "11/22",
          cust_addr: "Sea World",
          cust_email: "forkhair@mermaid.com",
          status: "complete",
          created_at: Time.now,
          updated_at: Time.now
        }
      }
      good_order = Order.new(order[:another_order])
      good_order.must_be :valid?
      start_count = Order.count

      post orders_path, params: order

      must_respond_with :redirect
      must_redirect_to orders_path
      Order.count.must_equal start_count + 1
      flash[:status].must_equal :success
      flash[:message].must_include "Successfully created order"
    end

    it "re-renders form when the order data is invalid" do
      order = {
        order: {
          cust_name: "Mermaid",
          merchant_id: 21,
          cust_cc: 12345,
          cust_cc_exp: "11/22",
          cust_addr: "Sea World",
          cust_email: "forkhair@mermaid.com",
          status: ""
        }
      }
      Order.new(order[:order]).wont_be :valid?
      start_count = Order.count

      post orders_path, params: order

      must_respond_with :bad_request
      Order.count.must_equal start_count
    end
  end

  describe "show" do
    it "returns success with valid id" do
      login_test_user
      order_id = Order.first.id
      get order_path(order_id)
      must_respond_with :success
    end

    it "returns not_found with invalid id" do
      login_test_user
      invalid_id = Order.last.id + 1
      get order_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "returns success if order product exists and changes are valid" do
      order = Order.first
      changes = {
        order: {
          cust_name: "Wienerschnitzel"
        }
      }
      order.update_attributes(changes[:order])
      order.must_be :valid?

      patch order_path(order), params: changes
      must_respond_with :redirect
      must_redirect_to order_path(order)

      order.reload
      order.cust_name.must_equal changes[:order][:cust_name]
    end

    it "returns not_found if work does not exist" do
      order = Order.first
      changes = {
        order: {
          cust_name: "Wienerschnitzel"
        }
      }
      order.update_attributes(changes[:order])
      order.must_be :valid?
      order.destroy

      patch order_path(order), params: changes
      must_respond_with :not_found
    end
  end

  # describe "destroy" do
  #   it "returns success and destroys if order exists" do
  #     order = Order.first
  #     order.must_be :valid?
  #     delete order_path(order)
  #     must_respond_with :redirect
  #     must_redirect_to orders_path
  #   end
  #
  #   it "returns not_found if work does not exist" do
  #     order = Order.first
  #     order.must_be :valid?
  #     delete order_path(order)
  #     delete order_path(order)
  #     must_respond_with :not_found
  #   end
  # end
end
