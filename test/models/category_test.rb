require "test_helper"

describe Category do
  let(:food_category) { categories(:food) }

  describe "relations" do

    it "has products" do
      food_category.must_respond_to :products
    end

    it "can have many products" do
      food_category.products << products(:chocolate)
      food_category.products.first.must_be_kind_of Product

      food_category.products << products(:tears)
      food_category.products.count.must_equal 2
      food_category.products.each do |product|
        product.must_be_kind_of Product
      end

      food_category.products.first.name.must_equal products(:chocolate).name

    end

    it "can have zero products" do
      new_category = Category.new(name: "services")
      new_category.save

      new_category.must_respond_to :products
      new_category.products.count.must_equal 0

    end
  end

  describe "validations" do
    let(:new_category) { Category.new }

    it "requires a name to be valid" do
      new_category.valid?.must_equal false
    end

    it "is valid if it has a name" do
      new_category.name = "service"
      new_category.valid?.must_equal true
    end

    it "requires a unique name to be valid" do
      new_category.name = categories(:food).name
      new_category.valid?.must_equal false
    end

  end
end
