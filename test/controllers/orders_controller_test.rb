require "test_helper"
#TODO Look at update test that is commented out

describe OrdersController do
  
  describe "index" do
    it "succeeds when there are orders" do
      Order.count.must_be :>, 0, "No works in the test fixtures"
      get orders_path
      must_respond_with :success
    end

    it "succeeds when there are no orders" do
      Order.destroy_all
      get orders_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "works" do
      get new_order_path
      must_respond_with :success
    end
  end

  describe "create" do
    it "creates an order with a status of pending" do
      #Arrange: nothing to arrange for the creation. Will always start with status of pending and all other values as nil
      start_count = Order.count
      #Act
      post orders_path
      #Assert
      Order.count.must_equal start_count + 1
    end
    it "sets the session[:order_id] to the id of the created order" do
      post orders_path
      session[:order_id].wont_equal nil
      session[:order_id].must_equal Order.last.id
    end
  end

  describe "show" do
    it "succeeds for an existing order" do
      get order_path(Order.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus order ID" do
      bogus_order_id = Order.last.id + 1
      get order_path(bogus_order_id)
      must_respond_with :not_found
    end
  end
  #
  describe "edit" do
    it "succeeds for an existing order" do
      order = orders(:pending_order)
      get edit_order_path(order.id)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus order ID" do
      bogus_order_id = Order.last.id + 1
      get edit_order_path(bogus_order_id)
      must_respond_with :not_found
    end

    it "does not allow edits to a complete order" do
      order = orders(:complete_order)
      get edit_order_path(order.id)
      must_redirect_to root_path
    end
  end

  describe "update" do
    it "succeeds for valid data and an existing order ID" do
      order = orders(:pending_order)
      order_data = {
        order: {
          email: "buyer@email.com",
          address: "100 Witchy Way, Seattle, WA",
          name: "Gale",
          card_number: "1234 1234 1234 1234",
          card_exp: "01/21",
          card_cvv: "546",
          zip_code: "98122"
        }
      }

      patch order_path(order.id), params: order_data
      must_redirect_to confirm_order_path(order.id)


      # Verify the DB was really modified
      Order.find(order.id).status.must_equal "complete"
    end

    it "resets the session[:order_id] to nil when order is complete" do
      order = orders(:pending_order)
      order_data = {
        order: {
          email: "buyer@email.com",
          address: "100 Witchy Way, Seattle, WA",
          name: "Gale",
          card_number: "1234 1234 1234 1234",
          card_exp: "01/21",
          card_cvv: "546",
          zip_code: "98122"
        }
      }

      patch order_path(order.id), params: order_data

      session[:order_id].must_equal nil
    end

    it "renders bad_request for insufficient buyer data" do
      order = orders(:pending_order)
      order_data = {
        order: {
          email: nil,
          address: "100 Witchy Way, Seattle, WA",
          name: "Gale",
          card_number: "1234 1234 1234 1234",
          card_exp: "01/21",
          card_cvv: "546",
          zip_code: "98122"
        }
      }

      patch order_path(order), params: order_data
      must_respond_with :bad_request

      # Verify the DB was not modified
      Order.find(order.id).status.must_equal "pending"
    end

    it "renders 404 not_found for a bogus order ID" do
      bogus_order_id = Order.last.id + 1
      get order_path(bogus_order_id)
      must_respond_with :not_found
    end

    it "does not allow changes to a complete order" do
      order = orders(:complete_order)
      patch order_path(order.id)
      must_redirect_to root_path
    end
  end

end
