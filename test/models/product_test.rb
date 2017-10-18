require "test_helper"

describe Product do
  let(:product) { Product.new }

  describe "validations" do
    it "can be created with required fields" do
      b = Product.new(name: "product", price: 10)

      b.must_be :valid?
    end #can be created

    it "requires a name" do
      b = Product.new(price: 10)
      b.wont_be :valid?
      b.errors.messages.must_include :name
    end #requires a name

    it "requires a unique name" do
      name = "test name"
      b1 = Product.create!(name: name, price: 10)
      b2 = Product.new(name: name, price: 10)

      b2.wont_be :valid?
    end #unique name

    it "requires a price" do
      b = Product.new(name: "name")
      b.wont_be :valid?
      b.errors.messages.must_include :price
    end

    it "requires price to be greater than 0" do
      b = Product.new(name: "name", price: 0)
      b.wont_be :valid?
      b.errors.messages.must_include :price
    end
  end #validation tests
end #all product tests
