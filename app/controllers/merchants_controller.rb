
class MerchantsController < ApplicationController
  before_action :find_merchant_by_params_id, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index, :show]

  def index
    @merchants = Merchant.all
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)

    if save_and_flash(@merchant)
      redirect_to merchants_path
    else
      render :new, status: :bad_request
    end
  end

  def show
    @merchant = Merchant.find_by(id: params[:id])
    # make sure syntax is ok
    # unless @merchant
    #   render: not_found
    # end
  end

  # def edit ; end
  #
  # def update
  #   @merchant.update_attribute( merchant_params)
  #
  #   if @merchant
  #     flash[:status] = :success
  #     flash[:message] = "Successfully saved #{@merchant.class} #{@merchant.id}"
  #   else
  #     flash.now[:status] = :failure
  #     flash.now[:message] = "Failed to save #{@merchant.class}"
  #     flash.now[:details] = @merchant.errors.messages
  #   end
  # end

  def destroy

  end

  private

  def merchant_params
    return params.require(:merchant).permit(:ususername, :email)
  end

  def find_merchant_by_params_id
    @merchant = Merchant.find_by(id: params[:id])

    unless @merchant
      head :not_found
    end
  end # end find_merchant_by_params_id
end
