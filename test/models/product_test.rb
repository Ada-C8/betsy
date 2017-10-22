require "test_helper"

# Are Relations Set up as Expected
# Do my validations catch invalid models and let valid ones through
# Do my custom methods return the correct data?
# Write at least one test for each Custom Method
# Write at least one test for each Model Relationship
# Write at least two tests for each validation (positive and negative)
# Write at least two tests for each scope
#

# has_many :order_products
# has_many :orders, through: :order_products
# has_many :reviews, dependent: :destroy


describe Product do
  let(:product) { Product.new }


  describe "validations" do

    it "can be created with required fields" do
      #failed when added merchant association
      b = Product.new(name: "product", price: 10, category_id: Category.first.id, merchant_id: Merchant.first.id)
      b.must_be :valid?
    end #can be created

    it "requires a name" do
      b = Product.new(price: 10, category_id: Category.first.id, merchant_id: Merchant.first.id )
      b.wont_be :valid?
      b.errors.messages.must_include :name
    end #requires a name

    it "requires a unique name" do
      name = "test name"
      b1 = Product.create!(name: name, price: 10, category_id: Category.first.id, merchant_id: Merchant.first.id)
      b2 = Product.new(name: name, price: 10, category_id: Category.first.id, merchant_id: Merchant.first.id)

      b2.wont_be :valid?
    end #unique name

    it "requires a price" do
      b = Product.new(name: "name", category_id: Category.first.id, merchant_id: Merchant.first.id)
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

    it "requires an associated category" do
      b = Product.new(name: "name", price: "10", merchant_id: 1)
      b.wont_be :valid?
      b.errors.messages.must_include :category_id
    end


  end #validation tests
end #all product tests
