require "test_helper"

describe Billing do
  before do
    @billing = billings(:one)
  end #before billing

  describe 'validate' do
    it "can be created and required fields cannot be nil" do
      @billing.must_be_kind_of Billing
      refute_nil @billing.id
      refute_nil @billing.name
      refute_nil @billing.street
      refute_nil @billing.apt
      refute_nil @billing.city
      refute_nil @billing.state
      refute_nil @billing.ship_zip
      refute_nil @billing.email
      refute_nil @billing.credit_card
      refute_nil @billing.exp
      refute_nil @billing.cvv
      refute_nil @billing.bill_zip
    end #can be created

    it "is invalid if any required fields are missing" do
      @billing.name = nil
      @billing.valid?.must_equal false

      @billing.street = nil
      @billing.valid?.must_equal false

      @billing.city = nil
      @billing.valid?.must_equal false

      @billing.state = nil
      @billing.valid?.must_equal false

      @billing.ship_zip = nil
      @billing.valid?.must_equal false

      @billing.email = nil
      @billing.valid?.must_equal false

      @billing.credit_card = nil
      @billing.valid?.must_equal false

      @billing.exp = nil
      @billing.valid?.must_equal false

      @billing.cvv = nil
      @billing.valid?.must_equal false

      @billing.bill_zip = nil
      @billing.valid?.must_equal false
    end #presence validation

    it "ship_zip must be 5 characters" do
      @billing.ship_zip = 123
      @billing.valid?.must_equal false
      @billing.errors.messages.must_include :ship_zip

      @billing.ship_zip = 12345
      @billing.valid?.must_equal true
    end #ship_zip

    it "bill_zip must be 5 characters" do
      @billing.bill_zip = 123
      @billing.valid?.must_equal false
      @billing.errors.messages.must_include :bill_zip

      @billing.bill_zip = 12345
      @billing.valid?.must_equal true
    end #bill zip

    it "Credit card number must be 16 characters" do
      @billing.credit_card = 123456789123456
      @billing.valid?.must_equal false
      @billing.errors.messages.must_include :credit_card

      @billing.credit_card = 1234567891234567
      @billing.valid?.must_equal true
    end #credit card
  end #all validations

end #all
