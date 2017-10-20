class MerchantsController < ApplicationController
  before_action :find_merchant_by_params_id, only: [:show, :edit, :update, :destroy]

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find_by(id: params[:id])
    # make sure syntax is ok
    # unless @merchant
    #   render: not_found
    # end
  end
end
