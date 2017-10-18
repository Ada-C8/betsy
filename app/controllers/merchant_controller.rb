class MerchantController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def new
    @Merchant = Merchant.new
  end

  def create

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end
end
