require "test_helper"

describe Merchant do
  # let(:merchant) {Merchant.new}
  # let(:spooky) {merchants(:spooky)} #gets books from the fixtures with this shorthand name for yml
  # let(:ghosty) {merchants(:ghosty)}

  it "must have a merchant name to be vaild" do
    merchant = Merchant.new(username: 'Spooky Books')
    merchant.valid?.must_equal true

  end

end
