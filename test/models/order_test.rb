require "test_helper"

describe Order do
  let(:item1) {order_items(:orderitem1)}
  let(:item2) {order_items(:orderitem2)}
  let(:order1) {orders(:pending_order)}
  let(:order2) {orders(:paid_order)}
  let(:product) { products(:soap)}

  let(:user) { users(:je)}


  describe "relations" do
    it "has many order_items" do
      order1.must_respond_to :order_items
      order1.must_be_kind_of Order
      order1.order_items.each do |item|
        item.must_be_kind_of OrderItem
      end
    end
  end

  describe "validations" do

    it "an order requires a status" do
      order_no_status = Order.new
      order_no_status.status = ""
      order_no_status.valid?.must_equal false
      order_no_status.errors.messages.must_include :status
    end

    it "requires that the status is either incomplete or paid" do
      order1.status.must_be_kind_of String
      order1.status.must_equal "incomplete"
    end

    it "accepts valid status" do
      valid_status = ["paid", "incomplete", "complete"]
      valid_status.each do |status|
        valid_order = Order.new(user_id: order1.user_id, status: status)
        valid_order.valid?.must_equal true
      end
    end

    it "rejects invalid status" do
      invalid_status = [1, nil, "no status", 0.5]
      invalid_status.each do |status|
        invalid_order = Order.new(user_id: order1.user_id, status: status)
        invalid_order.valid?.must_equal false
        invalid_order.errors.messages.must_include :status
      end
    end
  end

  describe "Order#total_cost" do

    it "order's total cost defaults to 0" do
      new_order = Order.create!(user_id: user.id, status: "incomplete")
      new_order.must_respond_to :total_cost
      new_order.total_cost.must_equal 0
    end


    it "accurately calculates total cost" do
      order1.total_cost.must_equal (order1.order_items.first.product.price * order1.order_items.first.quantity)

      test_total = 0
      order2.order_items.each do |order|
        test_total += (order.product.price * order.quantity)
      end
      order2.total_cost.must_equal test_total
    end
  end

  describe "custom model methods" do
    let(:bubbles) {users(:bubbles)}
    let(:user) {users(:tanja)}
    describe "self.by_user(user)" do
      it "returns a collection of orders that belong to the user" do
        Order.by_user(bubbles).must_be_kind_of Enumerable

        Order.by_user(bubbles).first.must_be_kind_of Order

        Order.by_user(bubbles).count.must_equal 1

      end

      it "returns an array of orders" do
        orders = Order.by_user(user).select { |order| order.status == "paid"}
        orders.must_be_kind_of Array
      end

      it "order(s) returned must be paid" do
        orders = Order.by_user(user).select { |order| order.status == "paid"}
        orders.each do |order|
          order.status.must_equal "paid"
        end
      end

      it "returns the right number of orders" do
        orders = Order.by_user(user).select { |order| order.status == "paid"}
        orders.count.must_equal 1
      end

    end
  end
end
