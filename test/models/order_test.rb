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

    end

    it "is created with a 'pending' status" do

    end
  end

  describe "find or create cart method" do
    it "Successfully finds order if order is in session" do

    end
    it "Creates a new order if no order exist" do

    end
  end
end
