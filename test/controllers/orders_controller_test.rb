require "test_helper"

describe OrdersController do

  describe "show" do
    it "return success when given a valid order id" do
      merchant = merchants(:fake_user)
      order = orders(:one)
      setup { login(merchant) }

      session[:order_id].must_equal order.id

      # order_id = Order.first.id
      # get order_path(order_id)
      # must_respond_with :success
    end #valid

    it "gives not_found for a bogus order id" do
      bogus_order_id = Order.last.id + 1

      get order_path(bogus_order_id)
      must_respond_with :not_found
    end # invalid id

    #will create  new cart if doesn't find one
    # it "returns not found when given an invalid product id" do
    #   order_id = Order.last.id + 1
    #   get order_path(order_id)
    #   must_respond_with :not_found
    # end #invalid
  end #show

  describe "Billing Form" do
    it "Will Render the Billing Form" do
      order_id = 1
      get billing_form_path
      must_respond_with :success
    end
  end

  describe "Submit" do
    it "will return success if order was submitted" do
      @billing = billings(:one)
      must_respond_with :success
    end

    it "will return failure if order was not submitted" do
    end
  end

  # def submit
  #   # billing = Billing.find_by(id:session[:order_id])
  #   @order = Order.find_by(id:session[:order_id], status: "pending")
  #   @order.subtract_products
  #
  #   @billing = Billing.new(billing_params)
  #
  #   if @billing.save
  #     @order.status = "paid"
  #     flash[:status]  = :success
  #     flash[:message] = "Successfully submitted your order"
  #     session[:order_id] = nil
  #   else
  #     flash.now[:status] = :failure
  #     flash.now[:message] = "Failed submit your order"
  #   end
  #   render :show_order
  # end

end #all
