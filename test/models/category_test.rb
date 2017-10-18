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





end
