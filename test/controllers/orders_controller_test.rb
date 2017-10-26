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
  end

  describe "show" do
    #note: I couldn't do session setup within the it block, so I had to pull this negative case out into a different describe block
    it "renders 404 not_found for a bogus order ID" do
      #show action finds the order by matching it to the session ID. Here there will be no session, so it should not find an order.
      get order_path(0)
      must_respond_with :not_found
    end
  end
  # #
  # describe "edit" do
  #   it "succeeds for an existing order" do
  #     setup { session_setup }
  #
  #     get edit_order_path(order.id)
  #     must_respond_with :success
  #   end
  #
  #   it "renders 404 not_found for a bogus order ID" do
  #     #no session, therefore can't find order.id
  #     get edit_order_path(order.id)
  #     must_respond_with :not_found
  #   end
  #
  #   it "allows edits to a complete order" do
  #     setup { session_setup }
  #     order = orders(:pending_order)
  #     order.status = "complete"
  #     order.save
  #     get edit_order_path(order.id)
  #     must_respond_with :success
  #   end
  #
  #   it "does not allow edits to a shipped order" do
  #     setup { session_setup }
  #     order = orders(:pending_order)
  #     order.status = "shipped"
  #     order.save
  #     get edit_order_path(order.id)
  #     must_redirect_to home_path
  #   end
  # end
  #
  # describe "update" do
  #   it "succeeds for valid data and an existing order ID" do
  #     order = orders(:pending_order)
  #     order_data = {
  #       order: {
  #         email: "buyer@email.com",
  #         address: "100 Witchy Way, Seattle, WA",
  #         name: "Gale",
  #         card_number: "1234 1234 1234 1234",
  #         card_exp: "01/21",
  #         card_cvv: "546",
  #         zip_code: "98122"
  #       }
  #     }
  #     patch order_path(order.id), params: order_data
  #     must_redirect_to confirm_order_path(order.id)
  #
  #     # Verify the DB was really modified
  #     Order.find(order.id).status.must_equal "complete"
  #   end
  #
  #   it "resets the session[:order_id] to nil when order is complete" do
  #     order = orders(:pending_order)
  #     order_data = {
  #       order: {
  #         email: "buyer@email.com",
  #         address: "100 Witchy Way, Seattle, WA",
  #         name: "Gale",
  #         card_number: "1234 1234 1234 1234",
  #         card_exp: "01/21",
  #         card_cvv: "546",
  #         zip_code: "98122"
  #       }
  #     }
  #
  #     patch order_path(order.id), params: order_data
  #
  #     session[:order_id].must_equal nil
  #   end
  #
  #   it "renders bad_request for insufficient buyer data" do
  #     order = orders(:pending_order)
  #     order_data = {
  #       order: {
  #         email: nil,
  #         address: "100 Witchy Way, Seattle, WA",
  #         name: "Gale",
  #         card_number: "1234 1234 1234 1234",
  #         card_exp: "01/21",
  #         card_cvv: "546",
  #         zip_code: "98122"
  #       }
  #     }
  #
  #     patch order_path(order), params: order_data
  #     must_respond_with :bad_request
  #
  #     # Verify the DB was not modified
  #     Order.find(order.id).status.must_equal "pending"
  #   end
  #
  #   it "renders 404 not_found for a bogus order ID" do
  #     bogus_order_id = Order.last.id + 1
  #     get order_path(bogus_order_id)
  #     must_respond_with :not_found
  #   end
  #
  #   it "does not allow changes to a complete order" do
  #     order = orders(:complete_order)
  #     patch order_path(order.id)
  #     must_redirect_to root_path
  #   end
  # end

end
