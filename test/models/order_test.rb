require "test_helper"

describe Order do
  let(:order) { Order.new }
  let(:order_one) { orders(:order_one) }

  describe "relations" do
    it "has a list of products" do
      pending_order = orders(:pending_order)
      product = products(:pointy_hat)

      pending_order.must_respond_to :products

      pending_order.products << product
      pending_order.products.count.must_equal 1
    end
  end

  describe "validations" do
    it "must have a valid status to be true" do
      order_one.valid?.must_equal true
      order_one.status = "incomplete"
      order_one.valid?.must_equal false
    end

    it "must have a status to be valid" do
      order_one.valid?.must_equal true
      order_one.status = nil
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :status

      order_one.status = " "
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :status
    end

    it "must have a valid email address to be true" do
      order_one.valid?.must_equal true
      order_one.email = "abcdefg"
      order_one.valid?.must_equal false
    end

    it "must have an email address to be valid" do
      order_one.valid?.must_equal true
      order_one.email = nil
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :email

      order_one.email = " "
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :email
    end

    it "must have a street address to be valid" do
      order_one.valid?.must_equal true
      order_one.address = nil
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :address

      order_one.address = " "
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :address
    end

    it "must have a name to be valid" do
      order_one.valid?.must_equal true
      order_one.name = nil
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :name
    end

    it "must have a valid card number to be true" do
      order_one.valid?.must_equal true
      order_one.card_number = 1234567
      order_one.valid?.must_equal false

      order_one.card_number = "not a number"
      order_one.valid?.must_equal false

      order_one.card_number = 12345678909876543
      order_one.valid?.must_equal false
    end

    it "must have a card number to be valid" do
      order_one.valid?.must_equal true
      order_one.card_number = nil
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :card_number
    end

    it "must have a valid expiration date to be true" do
      order_one.valid?.must_equal true
      order_one.card_exp = "March 9, 2017"
      order_one.valid?.must_equal true

      order_one.card_exp = "10/2018"
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :card_exp

      order_one.card_exp = "March 2017"
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :card_exp
    end

    it "must have an expiration date to be valid" do
      order_one.valid?.must_equal true
      order_one.card_exp = nil
      order_one.valid?.must_equal false
    end

    it "must have a valid card cvv to be true" do
      order_one.valid?.must_equal true
      order_one.card_cvv = "nine"
      order_one.valid?.must_equal false

      order_one.card_cvv = 12
      order_one.valid?.must_equal false

      order_one.card_cvv = 1234
      order_one.valid?.must_equal false
    end

    it "must have a card cvv to be valid" do
      order_one.valid?.must_equal true
      order_one.card_cvv = nil
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :card_cvv

      order_one.card_cvv = " "
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :card_cvv
    end

    it "must have a valid zip code to be true" do
      order_one.valid?.must_equal true
      order_one.zip_code = 9812500000
      order_one.valid?.must_equal false

      order_one.zip_code = 9812
      order_one.valid?.must_equal false

      order_one.zip_code = "98125-"
      order_one.valid?.must_equal false
    end

    it "must have a zip code to be valid" do
      order_one.valid?.must_equal true
      order_one.zip_code = nil
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :zip_code

      order_one.zip_code = " "
      order_one.valid?.must_equal false
      order_one.errors.messages.must_include :zip_code
    end
  end
end
