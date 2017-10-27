class MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update, :destroy]

  def index
    @merchants = Merchant.all
  end

  def new
    @merchant = Merchant.new
  end

  def show
    if @merchant == nil
      flash[:status] = :failure
      flash[:result_text] = "That merchant does not exist."
      redirect_to merchants_path, status: :not_found
    end
  end

  # def edit
  #   unless @merchant
  #     flash[:status] = :failure
  #     flash[:result_text] = "That merchant could not be found."
  #   end
  # end

  # def update
  #   redirect_to merchants_path unless @merchant
  #   redirect_to root_path unless @merchant
  #
  #   if @merchant.update_attributes merchant_params
  #     flash[:status] = :success
  #     flash[:result_text] = "Successfully updated merchant details!"
  #     redirect_to merchant_path(@merchant.id)
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   find_merchant
  #   redirect_to root_path
  # end

  private
  def merchant_params
    return params.require(:merchant).permit(:username, :email)
  end

  def find_merchant
    @merchant = Merchant.find_by(id: params[:id].to_i)
  end
end
