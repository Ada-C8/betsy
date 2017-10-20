require "test_helper"

describe MerchantsController do

  describe "show" do
    it "succeeds for an extant merchant" do
      get merchant_path(Merchant.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus merchant" do
      bogus_merchant_id = Merchant.last.id + 1
      get merchant_path(bogus_merchant_id)
      must_respond_with :not_found
    end
  end


  describe "create" do
    it "works" do
      merchant = {
        merchant: {
          oauth_provider: "github",
          oauth_uid: "99999",
          email: "somebody@somesite.com",
          username: "Somebody"
        }
      }
      Merchant.new(merchant[:merchant]).must_be :valid?
      start_count = Merchant.count
      post merchants_path, params: merchant
      flash[:status].must_equal :success
      must_respond_with :redirect
      must_redirect_to root_path
      Merchant.count.must_equal start_count + 1
    end

    #   it "adds order to the database and redirects when the data is valid" do
    #     order = {
    #       order: {
    #         cust_name: "Mermaid",
    #         merchant_id: 21,
    #         cust_cc: 12345,
    #         cust_cc_exp: "11/22",
    #         cust_addr: "Sea World",
    #         cust_email: "forkhair@mermaid.com",
    #         status: "complete"
    #       }
    #     }
    #     Order.new(order[:order]).must_be :valid?
    #     start_count = Order.count
    #
    #     post orders_path, params: order
    #
    #     must_respond_with :redirect
    #     must_redirect_to orders_path
    #     Order.count.must_equal start_count + 1
    #   end
    #
    #   it "re-renders form when the order data is invalid" do
    #     order = {
    #       order: {
    #         cust_name: "Mermaid",
    #         merchant_id: 21,
    #         cust_cc: 12345,
    #         cust_cc_exp: "11/22",
    #         cust_addr: "Sea World",
    #         cust_email: "forkhair@mermaid.com",
    #         status: ""
    #       }
    #     }
    #     Order.new(order[:order]).wont_be :valid?
    #     start_count = Order.count
    #
    #     post orders_path, params: order
    #
    #     must_respond_with :bad_request
    #     Order.count.must_equal start_count
    #   end
    # end
    #
    # #
    # describe "edit" do
    #   it "succeeds for an extant merchant ID" do
    #     get edit_merchant_path(Merchant.first)
    #     must_respond_with :success
    #   end
    #
    #   it "renders 404 not_found for a bogus merchant ID" do
    #     bogus_merchant_id = Merchant.last.id + 1
    #     # binding.pry
    #     get edit_merchant_path(bogus_merchant_id)
    #     must_respond_with :not_found
    #   end
  end

  describe "update" do

    it "returns success if the merchant ID is valid and the change is valid" do
      merchant = Merchant.first
      merchant_data = {
        merchant: {
          username: "changed username",
          email: merchant.email
        }
      }
      merchant.update_attributes(merchant_data[:merchant])
      merchant.must_be :valid?, "Test is invalid because the provided data will produce an invalid merchant"

      patch merchant_path(merchant), params: merchant_data

      must_respond_with :redirect
      must_redirect_to merchant_path(merchant)

      # Check that the change went through
      merchant.reload
      merchant.username.must_equal merchant_data[:merchant][:username]
    end
    #
    it "returns not_found if the merchant ID is invalid" do
      invalid_merchant_id = Merchant.last.id + 1
      merchant_data = {
        merchant: {
          username: "Changed username",
          merchant_id: Merchant.first.id
        }
      }

      patch merchant_path(invalid_merchant_id), params: merchant_data

      must_respond_with :not_found
    end
    #
    it "returns bad_request if the change is invalid" do
      merchant = Merchant.first
      invalid_merchant_data = {
        merchant: {
          email: ""
        }
      }
      # Check that the update is actually invalid
      merchant.update_attributes(invalid_merchant_data[:merchant])
      merchant.wont_be :valid?
      patch merchant_path(merchant), params: invalid_merchant_data

      must_respond_with :bad_request

      merchant.reload
      merchant.username.wont_equal invalid_merchant_data[:merchant][:username]
    end
  end
end
