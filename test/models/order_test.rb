require "test_helper"

describe Order do
  let(:bad_order) { Order.new(
      merchant_id: :grace,
      cust_name: "John",
      cust_cc: "12345",
      cust_cc_exp: "11/22",
      cust_addr: "Sea World",
      cust_email: "forkhair@mermaid.com",
      status: "")
  }

  describe "validations" do

  end

  it "must be valid" do
    good_order.must_be :valid?
  end
end
