require "test_helper"

describe Order do
  describe "relations" do
    it "has a list of products" do
      new = orders(:new)
      new.must_respond_to :products
      new.products.each do |product|
        product.must_be_kind_of Product
      end
    end
  end
end
