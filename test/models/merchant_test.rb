require "test_helper"

describe Merchant do
  before do
    @m = Merchant.new
    @valid_test_m = Merchant.new(username: "tricycle", email: "tricycle@tricycle.com" )
  end

  describe "relations" do
    it "responds to products" do
      @m.must_respond_to :products
    end
  end

  describe "validations" do
    it "is valid when given valid merchant data" do
      @valid_test_m.must_be :valid?
    end

    it "requires a username" do
      merchant = Merchant.new(username: "", email: "email@email.com")
      merchant.valid?.must_equal false
      merchant.errors.messages.must_include :username
    end

    it "requires an email" do
      merchant = Merchant.new(username: "username", email: "")
      merchant.valid?.must_equal false
      merchant.errors.messages.must_include :email
    end

    it "requires an email in a certain format" do
      merchant = Merchant.new(username: "username", email: "tricycle")
      merchant.valid?.must_equal false
      merchant.errors.messages.must_include :email

      merchant1 = Merchant.new(username: "username", email: "tricycle@")
      merchant1.valid?.must_equal false
      merchant.errors.messages.must_include :email

      merchant2 = Merchant.new(username: "username", email: "tricycle@tricycle")
      merchant2.valid?.must_equal false
      merchant.errors.messages.must_include :email

      merchant3 = Merchant.new(username: "username", email: "tricycle@tricycle.")
      merchant3.valid?.must_equal false
      merchant.errors.messages.must_include :email
    end
  end
end