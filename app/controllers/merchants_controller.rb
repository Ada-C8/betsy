class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def new
    @merchant = Merchant.new
  end

  def create

  end

  def show
    @merchant = Merchant.find_by(id: params[:id])

    unless @merchant
      head :not_found
    end
  end

  def edit
    @merchant = Merchant.find_by(id: params[:id])

    unless @merchant
      head :not_found
    end
  end

  def update

  end

  def destroy

  end

end
