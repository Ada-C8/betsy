require "test_helper"

describe OrdersController do
  let(:item1) {order_items(:orderitem1)}
  let(:item2) {order_items(:orderitem2)}
  let(:order1) {orders(:pending_order)}
  let(:order2) {orders(:paid_order)}
  let(:tanja) {users(:tanja)}
  let(:amy) {users(:amy)}
  let(:chocolate) { products(:chocolate) }


  describe "Order#index" do
    it "succeeds when there are Orders" do
      order1
      OrderItem.count.must_be :>, 0, "No Orders in the test fixtures"
      get orders_path
      must_respond_with :success
    end

    it "succeeds when there are no Orders" do
      Order.destroy_all
      get orders_path
      must_respond_with :success
    end
  end

  describe "Order#new" do
    it "works" do
      get new_order_path
      must_respond_with :success
    end
  end

  describe "Order#edit" do
    it "works" do
      get edit_order_path(order1.id)
      must_respond_with :success
    end

    it "renders 404 not_found for a non-existent order" do
      id  = order1.id
      order1.destroy
      get edit_order_path(id)
      must_respond_with :not_found
    end
  end

  describe "Order#show" do
    it "can view order show page" do
      get order_path(order1.id)
      must_respond_with :success
    end
  end

  describe "Order#place_order" do
    it "changes order status to paid with valid inputs" do
      id = order1.id
      order_data = {
        order: {
          customer_name: order1.customer_name,
          email: order1.email,
          mailing_address: order1.mailing_address,
          cc_number: order1.cc_number,
          cc_expiration_date: order1.cc_expiration_date,
          cc_cvv: order1.cc_cvv,
          zipcode: order1.zipcode,
        }
      }

      get root_path
      order_id = session[:order_id]
      post product_order_items_path(chocolate.id), params: { order_item: {quantity: 2, product_id: chocolate.id} }

      my_order_item = OrderItem.find_by(order_id: order_id)

      my_order_item.wont_be_nil
      order = Order.find_by(id: order_id)
      order.status.must_equal "incomplete"
      patch place_order_path, params: order_data
      Order.find_by(id: order_id).status.must_equal "paid"

    end

    it "does not change order status to paid with invalid inputs" do
      id = order1.id
      order_data = {
        order: {
          customer_name: order1.customer_name,
          email: order1.email,
          mailing_address: order1.mailing_address,
          cc_number: order1.cc_number,
          cc_expiration_date: order1.cc_expiration_date,
          cc_cvv: order1.cc_cvv,
          zipcode: order1.zipcode,
        }
      }
      # order has 0 order items
      get root_path
      order_id = session[:order_id]
      order = Order.find_by(id: order_id)
      puts "ORDER HAS #{order.order_items.count}"
      puts "order status is #{order.status}"
      order.status.must_equal "incomplete"
      patch place_order_path, params: order_data
      order.status.must_equal "incomplete"
    end

    it "deletes quantity of order_item from inventory" do
      product = Product.find_by_id(chocolate.id)
      count = product.quantity

      id = order1.id
      order_data = {
        order: {
          customer_name: order1.customer_name,
          email: order1.email,
          mailing_address: order1.mailing_address,
          cc_number: order1.cc_number,
          cc_expiration_date: order1.cc_expiration_date,
          cc_cvv: order1.cc_cvv,
          zipcode: order1.zipcode,
        }
      }

      get root_path
      order_id = session[:order_id]
      post product_order_items_path(chocolate.id), params: { order_item: {quantity: 2, product_id: chocolate.id} }

      my_order_item = OrderItem.find_by(order_id: order_id)

      order = Order.find_by(id: order_id)

      patch place_order_path, params: order_data

      product_after = Product.find_by_id(chocolate.id)

      product_after.quantity.must_equal count - 2

    end

    it "does not delete if quantity of order_item is more than inventory" do
      product = Product.find_by_id(chocolate.id)
      count = product.quantity

      id = order1.id
      order_data = {
        order: {
          customer_name: order1.customer_name,
          email: order1.email,
          mailing_address: order1.mailing_address,
          cc_number: order1.cc_number,
          cc_expiration_date: order1.cc_expiration_date,
          cc_cvv: order1.cc_cvv,
          zipcode: order1.zipcode,
        }
      }

      get root_path
      order_id = session[:order_id]
      post product_order_items_path(chocolate.id), params: { order_item: {quantity: 100, product_id: chocolate.id} }

      my_order_item = OrderItem.find_by(order_id: order_id)

      order = Order.find_by(id: order_id)

      patch place_order_path, params: order_data

      product_after = Product.find_by_id(chocolate.id)

      product_after.quantity.must_equal count

    end

  end



end
