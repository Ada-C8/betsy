class MerchantsController < ApplicationController
  # Thought process - That we should have a merchant page, which the merchant can view (aka Account page), you can also create a new merchant, edit, update, and delete.

  before_action :authenticate_user, only: [:show, :edit, :update]
  before_action :find_merchant, except: :index
  # before_action :authorize_merchant, only: [:show]

  # this is the only public route
  def index
    @merchants = Merchant.order('username ASC')
  end

  # this is ONLY FOR THE AUTHORIZED MERCHANT
  def show
    unless @merchant
      render_404
      return
    end

    return if !authorize_merchant
    # if merchant_id is same as logged in
    @products = @merchant.products
    # orders
    @paid = @merchant.order_items.where(status: "paid")
    @complete = @merchant.order_items.where(status: "complete")
    @canceled = @merchant.order_items.where(status: "canceled")
  end


  private

  def merchant_params
    return params.require(:merchant).permit(:username, :email, :uid, :provider, :user_id)
  end

  def find_merchant
    @merchant = Merchant.find_by(id: params[:id])
  end
end
