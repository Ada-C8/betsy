require "test_helper"

describe Order do
  let(:order) { Order.new }

  it "must be valid" do
    value(order).must_be :valid?
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
