require "test_helper"

describe Category do
  let(:category) {Category.new}
  let(:brooms) {categories(:brooms)}
  let(:cauldrons) {categories(:cauldrons)}

  it "must have a category name to be valid" do
    brooms.valid?.must_equal true
    brooms.name = nil
    brooms.valid?.must_equal false
  end

  it "requires a unique category name" do
    category = "broom handles"
    category1 = Category.new(name: category)
    category1.save!

    category2 = Category.new(name: category)
    result = category2.save
    result.must_equal false
    category2.errors.messages.must_include :name
  end

  it "must not have a category name of more than 20 characters" do
    category = Category.new(name: "various colored sheets for ghosts")
    category.valid?.must_equal false
  end

  it "has a list of products in it" do
    category = categories(:brooms)
    product = products(:pointy_hat)

    category.must_respond_to :products

    category.products.count.must_equal 0
    category.products << product
    category.products.count.must_equal 1
  end
end
