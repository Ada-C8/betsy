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
      product1 = products(:fake_product1)
      product2 = products(:fake_product2)

      op1 = order_products(:op_one)
      op2 = order_products(:op_two)

      # order = Order.create!(
      #   status: "pending"
      # )

      op1.order = order
      op1.order_id = order.id
      op1.save!
      op2.order = order
      op2.save!



      order.subtract_product.must_equal true
      # use reload when the database has changed and the local variable goes stale e.g. subtract_product updates the database and product1 was not updated.
      expected_stock = product1.stock - op1.quantity
      product1.reload
      product1.stock.must_equal expected_stock

      expected_stock = product2.stock - op2.quantity
      product2.reload
      product2.stock.must_equal expected_stock

    end

    it "returns false when the database is not updated for any reason" do
      # step 1 (set up for the test)

      product1 = products(:fake_product1)
      product2 = products(:fake_product2)

      op1 = order_products(:op_one)
      op2 = order_products(:op_two)

      # category = Category.create!(
      #   category_name: "stuff"
      # )
      #
      # product1 = Product.create!(
      #   id: 1,
      #   name: "MyString",
      #   description: "MyString",
      #   price: 1,
      #   stock: 3,
      #   category_id: category,
      #   merchant_id: 1
      # )
      #
      # product2 = Product.create!(
      #   id: 2,
      #   name: "MyString",
      #   description: "MyString",
      #   price: 1,
      #   stock: 1,
      #   category_id: 1,
      #   merchant_id: 1
      # )
      #
      # OrderProduct.create!(
      #   product: product1,
      #   order_id: 1,
      #   quanitity: 4
      # )
      #
      # OrderProduct.create!(
      #   product: product2,
      #   order_id: 1,
      #   quanitity: 1
      # )
      # # step 2 (don't remember name)
      # order = Order.create!(
      #   status: "pending"
      # )
      # Assert
      order.subtract_product.must_be false
    end
  end
end
