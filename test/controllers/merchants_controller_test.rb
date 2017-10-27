require "test_helper"

describe MerchantsController do
  describe "index" do
    it "renders page with all merchants" do
      get merchants_path
      must_respond_with :success
    end

    it "responds with success when there are no merchants" do
      Merchant.destroy_all
      get merchants_path
      must_respond_with :success
    end
  end #end index


  describe "show" do
    it "success for vaild merchant ID" do
      get merchant_path(Merchant.first.id)
      must_respond_with :success
    end

    it "gives not_found for bogus merchant ID" do
      bogus_merchant = Merchant.last.id + 1

      get merchant_path(bogus_merchant)
      must_respond_with :not_found

    end
  end # end show
end #all
# describe "new" do
#   it "Successfully makes a new merchant" do
#     get new_merchant_path
#     must_respond_with :success
#   end
# end # end new

# describe "create" do
#   it "adds the merchant to the DB and redirects when the merchant data is valid" do
#     merchant_data = {
#       merchant: {
#         username: "Test merchant",
#         email: "fake@email.com"
#       }
#     }
#
#     start_merchant_count = Merchant.count
#
#     Merchant.new(merchant_data[:merchant]).must_be :valid?
#
#     post merchants_path, params: merchant_data
#
#     must_respond_with :redirect
#     must_redirect_to merchants_path
#
#     Merchant.count.must_equal start_merchant_count + 1
#   end
# end



# describe "edit" do
#   it "success for vaild merchant ID" do
#     get edit_merchant_path(Merchant.first.id)
#     must_respond_with :success
#   end
#
#   it "gives not_found for bogus merchant ID" do
#     bogus_merchant = Merchant.last.id + 1
#     get edit_merchant_path(bogus_merchant)
#     must_respond_with :not_found
#   end
# end
#
# describe "update" do
#   it "returns success if the merchant ID is valid and the change is valid" do
#     merchant = Merchant.first
#     merchant_data = {
#       merchant: {
#         username: "test-user",
#         email: "fake@fake.com"
#       }
#     }
#     merchant.update_attributes(merchant_data[:merchant])
#
#     merchant.must_be :valid?, "Test is invalid because the provided data will produce an invalid merchant"
#
#     patch merchant_path(merchant), params: merchant_data
#
#
#     must_respond_with :redirect
#     must_redirect_to merchant_path(merchant)
#
#     # Check that the change went through
#     merchant.reload
#     merchant.username.must_equal merchant_data[:merchant][:username]
#
#
#   end
