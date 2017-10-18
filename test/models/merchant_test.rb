require "test_helper"

describe Merchant do
  let(:merchant) {Merchant.new}
  let(:spooky) {merchants(:spooky)}
  let(:ghosty) {merchants(:ghosty)}

  it "must have a merchant name to be valid" do
    spooky.valid?.must_equal true
    spooky.username = nil
    spooky.valid?.must_equal false
  end

  it "must have a merchant email to be valid" do
    spooky.valid?.must_equal true
    spooky.email = nil
    spooky.valid?.must_equal false
  end

  it "requires a unique merchant username" do
    username = "Ghouls Are Us"
    email1 = "ghosts@gmail.com"
    email2 = "sweepsthebroom@gmail.com"
    merchant1 = Merchant.new(username: username, email: email1)
    merchant1.save!

    merchant2 = Merchant.new(username: username, email: email2)
    result = merchant2.save
    result.must_equal false
    merchant2.errors.messages.must_include :username
  end

  it "requires a unique merchant email" do
    username1 = "Ghouls Are Us"
    username2 = "Spooky Woods"
    email = "ghosts@gmail.com"
    merchant1 = Merchant.new(username: username1, email: email)
    merchant1.save!

    merchant2 = Merchant.new(username: username2, email: email)
    result = merchant2.save
    result.must_equal false
    merchant2.errors.messages.must_include :email
  end
end
