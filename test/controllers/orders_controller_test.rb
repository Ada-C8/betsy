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

    it "succeeds when there are orders with a given status" do
      get orders_path, params: {status: "pending"}
      must_respond_with :success
    end

    it "succeeds when there are no orders with a given status" do
      get orders_path, params: {status: "nothing has this status"}
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
      Order.last.status.must_equal "pending"
    end

    it "sets the session[:order_id] to the id of the created order" do
      post orders_path
      session[:order_id].wont_equal nil
      session[:order_id].must_equal Order.last.id
    end
  end

  describe "show" do
    setup { session_setup }

    before do
      @order = Order.find_by(id: session[:order_id])
    end

    it "succeeds for an existing order" do
      get order_path(@order.id)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus order ID" do
      @order.destroy
      get order_path(@order.id)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    setup { session_setup }

    before do
      @order = Order.find_by(id: session[:order_id])
    end

    it "succeeds for an existing order" do
      get edit_order_path(@order.id)
      must_respond_with :success
    end

    it "allows edits to a complete order" do
      @order.status = "complete"
      @order.save
      get edit_order_path(@order.id)
      must_respond_with :success
    end

    it "does not allow edits to a shipped order" do
      @order.status = "shipped"
      @order.save
      get edit_order_path(@order.id)
      must_redirect_to home_path
    end

    it "renders 404 not_found for a bogus order ID" do
      @order.destroy
      get edit_order_path(@order.id)
      must_respond_with :not_found
    end
  end

  describe "update" do
    setup { session_setup }

    before do
      @order = Order.find_by(id: session[:order_id])
    end

    it "succeeds for valid data and an existing order ID" do
      order_data = {
        order: {
          email: "buyer@email.com",
          address: "100 Witchy Way",
          city: "Seattle",
          state: "Washington",
          name: "Gale",
          card_number: 1234123412341234,
          card_exp: "Sun, 1 Oct 2017",
          card_cvv: 546,
          zip_code: "98122"
        }
      }
      patch order_path(@order.id), params: order_data
      must_redirect_to order_confirm_order_path(@order.id)

      # Verify the DB was really modified
      Order.find(@order.id).status.must_equal "complete"
    end

    it "resets the session[:order_id] to nil when order is complete" do
      order_data = {
        order: {
          email: "buyer@email.com",
          address: "100 Witchy Way",
          city: "Seattle",
          state: "Washington",
          name: "Gale",
          card_number: 1234123412341234,
          card_exp: "Sun, 1 Oct 2017",
          card_cvv: 546,
          zip_code: "98122"
        }
      }

      patch order_path(@order.id), params: order_data

      session[:order_id].must_equal nil
    end

    it "renders bad_request for insufficient buyer data and does not change status to complete" do
      order_data = {
        order: {
          email: nil,
          address: "100 Witchy Way",
          city: "Seattle",
          state: "Washington",
          name: "Gale",
          card_number: 1234123412341234,
          card_exp: "Sun, 1 Oct 2017",
          card_cvv: 546,
          zip_code: "98122"
        }
      }

      patch order_path(@order.id), params: order_data
      must_respond_with :bad_request

      # Verify the DB was not modified
      Order.find(@order.id).status.must_equal "pending"
    end

    it "renders 404 not_found for a bogus order ID" do
      order_data = {
        order: {
          email: "buyer@email.com",
          address: "100 Witchy Way",
          city: "Seattle",
          state: "Washington",
          name: "Gale",
          card_number: 1234123412341234,
          card_exp: "Sun, 1 Oct 2017",
          card_cvv: 546,
          zip_code: "98122"
        }
      }

      @order.destroy
      get order_path(@order.id), params: order_data
      must_respond_with :not_found
    end

    it "does not allow changes to an order with the status of shipped" do
      #can't initialize a session with an order that has the shipped status
    end
  end
  describe "#shipped" do

    setup { session_setup }

    before do
      @order = Order.find_by(id: session[:order_id])
    end

    it "Allow the merchant to change an order's status from complete to shipped" do
      #can't initialize a session with an order that has the shipped status
    end
    it "Doesn't allow the merchant to change an order's status to shipped FROM pending" do
      patch ship_order_path(@order.id)
      must_redirect_to home_path
    end
  end
end
