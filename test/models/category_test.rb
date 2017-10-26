require "test_helper"
#

describe Category do
  let(:category) { Category.new }

  words = "a" * 30
  long = "a" * 31

  it "can be created with required fields" do
    b = Category.new(category_name: "Category")
    b.must_be :valid?
  end #can be created

  it "requires a name" do
    b = Category.new(category_name: "")
    b.wont_be :valid?
    b.errors.messages.must_include :category_name
  end #requires a name

  it "requires a unique name" do
    name = "test name"
    b1 = Category.create!(category_name: name)
    b2 = Category.new(category_name: name)

    b2.wont_be :valid?
  end #unique name

  it "will allow a name up to 30 characters" do
    b = Category.new(category_name: words)
    b.must_be :valid?
  end

  it "will not accept a name over 30 characters" do
    b = Category.new(category_name: long)
    b.wont_be :valid?
    b.errors.messages.must_include :category_name
  end
end
