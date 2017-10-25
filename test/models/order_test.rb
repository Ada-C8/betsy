require "test_helper"

describe Order do
  let(:order) { Order.new }

  describe "validations" do
    ## no validations currently
  end

  describe "associations" do
    it "responds to order_product" do
      order = Order.first
      order.must_respond_to :order_products
    end

    it "responds to product" do
      order = Order.first
      order.must_respond_to :products
    end
  end

  describe "start new order method" do
    it "can be created" do
      Order.start_new_order
      Order.count.must_equal start_order_count + 1
    end

    it "is created with a 'pending' status" do
      order = Order.start_new_order
      order.status.must_equal "pending"
    end
  end

  describe "find or create cart method" do
    it "Successfully finds order if order is in session" do
      new_order = Order.start_new_order
      order_id = new_order.id
      order = Order.find_or_create_cart(order_id)
      order.id.must_equal order_id
    end
    it "Creates a new order if no order exist" do
      order_id = order.id
      start_order_count = Order.count
      Order.find_or_create_cart(order_id)
      Order.count.must_equal start_order_count + 1
    end
  end

  describe "subtract_product" do
    it "returns true when the database is updated" do
      order1 = Product.create!(
        product_id: 1,
        order_id: 1,
        stock: 3
      )

      order2 = Product.create!(
        product_id: 2,
        order_id: 1,
        stock: 2
      )

      OrderProduct.create!(
        product_id: 1,
        order_id: 1,
        quanitity: 1
      )

      OrderProduct.create!(
        product_id: 2,
        order_id: 1,
        quanitity: 1
      )

      order = Order.create!(
        status: pending
      )


      order.subtract_product.must_be true
      order1.stock.must_be 2
      order2.stock.must_be 1

    end

    it "returns false when the database is not updated for any reason" do
      # step 1 (set up for the test)
      order1 = Product.create!(
        product_id: 1,
        order_id: 1,
        stock: 3
      )

      order2 = Product.create!(
        product_id: 2,
        order_id: 1,
        stock: 2
      )

      OrderProduct.create!(
        product_id: 1,
        order_id: 1,
        quanitity: 4
      )

      OrderProduct.create!(
        product_id: 2,
        order_id: 1,
        quanitity: 1
      )
      # step 2 (don't remember name)
      order = Order.create!(
        status: pending
      )
      # Assert
      order.subtract_product.must_be false
    end
  end
end
