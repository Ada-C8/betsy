require "test_helper"

describe Order do
  let(:order) { Order.new }

  describe "relationships" do
    it "has a collection of order items" do
      p_id = Product.first.id
      o = Order.new
      o.save!


      o.must_respond_to :order_items
      o.order_items.must_be :empty?
      oi = OrderItem.create!(product_id: p_id, quantity: 1, order: o)
      o.order_items.must_include oi
    end

    it "has a collection of products through order_item" do
      p_id = Product.first.id
      o = Order.new
      o.save!

      o.must_respond_to :products
      o.products.must_be :empty?
      o.products.wont_include Product.first
      oi = OrderItem.create!(product_id: p_id, quantity: 1, order: o)
      o.products.must_include Product.first
    end # it has a collection of producs

    it "has one billing" do
      o = Order.new
      o.save!

      o.must_respond_to :billing
      o.billing.must_equal nil
      b = Billing.create!(order_id: o.id, zip: "123", cc_name: "di", cc_number: "1234", cc_exp: Date.today, cc_cvv: "1234", address: "whatever", email: "yahoo")
      Order.find(o.id).billing.must_equal b
    end

  end # relationships


  describe "update_status" do
    it "changes order status to shipped if all order items are shipped" do
      o = Order.new(status: "paid")
      oi = OrderItem.create!(product_id: Product.first.id, quantity: 1, order: o)
      oi2 = OrderItem.create!(product_id: Product.last.id, quantity: 5, order: o)
      oi.shipped_status = true
      oi.save
      oi2.shipped_status = true
      oi2.save
      o.status.must_equal "paid"
      o.update_status
      o.status.must_equal "shipped"
    end

    it "does not change order status to shipped if not all order items are shipped" do
      o = Order.new(status: "paid")
      oi = OrderItem.create!(product_id: Product.first.id, quantity: 1, order: o)
      oi2 = OrderItem.create!(product_id: Product.last.id, quantity: 5, order: o)
      oi.shipped_status = true
      oi.save
      oi2.shipped_status = false
      oi2.save
      o.status.must_equal "paid"
      o.update_status
      o.status.must_equal "paid"
    end

    # it "changes order status back to paid if one or more order items are unmarked as shipped" do
    #   #TODO: Diane fix this test a la Jaimie
    #   o = Order.new(status: "paid")
    #   oi = OrderItem.create!(product_id: Product.first.id, quantity: 1, order: o)
    #   oi2 = OrderItem.create!(product_id: Product.last.id, quantity: 5, order: o)
    #   oi.shipped_status = true
    #   oi.save
    #   oi2.shipped_status = true
    #   oi2.save
    #   o.status.must_equal "paid"
    #   o.update_status
    #   o.status.must_equal "shipped"
    #
    #   oi3= OrderItem.find_by(id: oi2.id)
    #   oi3.shipped_status = false
    #   oi3.save
    #   puts "OI2.SHIPPED_STATUS #{oi3.shipped_status}"
    #   o.update_status
    #   Order.find_by(id: o.id).status.must_equal "paid"
    # end
  end


  describe "calculate_total" do
    it "will calculate the total when there are items in the order" do
      o = orders(:pending)
      total = 67.75
      o.calculate_total.must_equal total
    end # works when there are items in the cart

    it "will calculate the total as $0 if there are no items in the order" do
      o = orders(:empty)
      total = 0
      o.calculate_total.must_equal total
    end # works when there are no items in the cart
  end # calculate_total
end
