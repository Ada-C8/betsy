class MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new merchant_params
    if @merchant.save
      flash[:status] = :success
      flash[:result_text] = "Successfully created new merchant!"
      redirect_to merchant_path(@merchant.id)
    else
      flash.now[:status] = :failure
      flash[:result_text] = "Could not create new merchant."
      render :new
    end
  end

  def show
    @merchant = Merchant.find( params[:id].to_i )
    if @merchant == nil
      flash[:status] = :failure
      flash[:result_text] = "That merchant does not exist."
      redirect_to merchants_path, status: :not_found
    end
  end

  def edit
    @merchant = Merchant.find_by(id: params[:id].to_i)

    unless @merchant
      flash[:status] = :failure
      flash[:result_text] = "That merchant could not be found."
    end
  end

  def update
    @merchant = Merchant.find_by(id: params[:id].to_i)
    redirect_to root_path unless @merchant

    if @merchant.update_attributes merchant_params
      flash[:status] = :success
      flash[:result_text] = "Successfully updated merchant details!"
      redirect_to merchant_path(@merchant.id)
    else
      render :edit
    end
  end

  def destroy
    @merchant = Merchant.find_by(id: params[:id]).destroy

    if !@merchant
      redirect_to merchants_path, status: :not_found
    elsif @category.destroy
      flash[:status] = :success
      flash[:result_text] = "That merchant has been deleted."
      redirect_to merchants_path
    else
      flash[:status] = :failure
      flash[:result_text] = "That merchant is unable to be deleted."
      redirect_to merchants_path
    end
  end

  private
  def merchant_params
    return params.require(:merchant).permit(:username, :email)
  end
end
