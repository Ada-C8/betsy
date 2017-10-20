require "test_helper"

describe Order do
  let(:bad_order) { Order.new(
    merchant_id: :grace,
    cust_name: "John",
    cust_cc: "12345",
    cust_cc_exp: "11/22",
    cust_addr: "Sea World",
    cust_email: "forkhair@mermaid.com",
    status: "")
  }

  describe "validations" do
    it "can be created with valid data" do
      orders(:order).must_be :valid?
    end

    it "won't be valid without status" do
      bad_order.wont_be :valid?
      bad_order.errors.messages.must_include :status
    end
    it "won't be valid without cust_name" do
      bad_order.status = "complete"
      bad_order.cust_name = ""
      bad_order.wont_be :valid?
      bad_order.errors.messages.must_include :cust_name
    end
    it "won't be valid without :cust_cc" do
      bad_order.cust_cc = ""
      bad_order.wont_be :valid?
      bad_order.errors.messages.must_include :cust_cc
    end
    it "won't be valid without :cust_cc_exp" do
      bad_order.cust_cc_exp = ""
      bad_order.wont_be :valid?
      bad_order.errors.messages.must_include :cust_cc_exp
    end
    it "won't be valid without :cust_addr" do
      bad_order.cust_addr = ""
      bad_order.wont_be :valid?
      bad_order.errors.messages.must_include :cust_addr
    end
    it "won't be valid without :cust_name" do
      bad_order.cust_name = ""
      bad_order.wont_be :valid?
      bad_order.errors.messages.must_include :cust_name
    end
    it "won't be valid without :cust_email" do
      bad_order.cust_email = ""
      bad_order.wont_be :valid?
      bad_order.errors.messages.must_include :cust_email
    end
    it "won't be valid without :cust_email" do
      bad_order.cust_email = ""
      bad_order.wont_be :valid?
      bad_order.errors.messages.must_include :cust_email
    end
    it "won't be valid if email format is bad" do
      bad_order.cust_email = "Email"
      bad_order.wont_be :valid?
      bad_order.errors.messages.must_include :cust_email
    end
    it "won't be valid without order products" do
      bad_order.wont_be :valid?
      bad_order.errors.messages.must_include :products
    end
  end
  describe "releationships" do
    describe "order products" do
      it "will be valid with order products" do
        orders(:order).must_be :valid?
      end
      it "contains an array of Products" do
        orders(:order).order_products.each do |product|
          product.must_be_kind_of OrderProduct
        end
      end
      it "won't be valid without order products" do
        bad_order.products.must_equal []
        bad_order.wont_be :valid?
      end
    end
    describe "merchant relationship" do
      it "can have a merchant" do
        orders(:order).must_respond_to :merchant
      end
    end
  end
  # it "has a list of reviews" do
  #   review = merchants(:ada)
  #   review.must_respond_to :reviews
  #   review.reviews.each do |review|
  #     review.must_be_kind_of Review
  #   end
  # end
end
