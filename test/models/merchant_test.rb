require "test_helper"

describe Merchant do
  let(:merchant) {Merchant.new}
  let(:spooky) {merchants(:spooky)}
  let(:ghosty) {merchants(:ghosty)}

  it "must have a merchant name to be vaild" do
    spooky.valid?.must_equal true
    spooky.username = nil
    spooky.valid?.must_equal false
  end

  it "must have a merchant email to be vaild" do
    spooky.valid?.must_equal true
    spooky.email = nil
    spooky.valid?.must_equal false
  end

end
