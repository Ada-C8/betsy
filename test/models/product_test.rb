require "test_helper"

describe Product do
  let(:product) { Product.new }


  describe "validations" do
    it "can be created with required fields" do
      #failed when added merchant association
      b = Product.new(name: "product", description: "a product", price: 10, stock: 10, category_id: 1, photo_URL: "photo.com", merchant_id: 1)
      b.must_be :valid?
    end #can be created

    it "requires a name" do
      b = Product.new(price: 10, category_id: 1, merchant_id: 1 )
      b.wont_be :valid?
      b.errors.messages.must_include :name
    end #requires a name

    it "requires a unique name" do
      name = "test name"
      b1 = Product.create!(name: name, price: 10, category_id: 1, merchant_id: 1)
      b2 = Product.new(name: name, price: 10, category_id: 1, merchant_id: 1)

      b2.wont_be :valid?
    end #unique name

    it "requires a price" do
      b = Product.new(name: "name", category_id: 1, merchant_id: 1)
      b.wont_be :valid?
      b.errors.messages.must_include :price
    end

    it "requires price to be greater than 0" do
      b = Product.new(name: "name", price: 0, category_id: 1, merchant_id: 1)
      b.wont_be :valid?
      b.errors.messages.must_include :price
    end

    it "requires an associated merchant" do
      b = Product.new(name: "name", price: "10", category_id: 1)
      b.wont_be :valid?
      b.errors.messages.must_include :merchant_id
    end






  end #validation tests
end #all product tests
