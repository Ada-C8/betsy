class MerchantsController < ApplicationController
  before_action :find_merchant_by_params_id, only: [:show, :edit, :update, :destroy]

  def index
    @merchants = Merchant.all
  end

  def show
    @user = User.find_by(id: params[:id])
    # make sure syntax is ok
    # unless @user
    #   render: not_found
    # end
  end
end
