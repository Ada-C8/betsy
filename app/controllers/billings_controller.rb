class BillingsController < ApplicationController
  def new
    @billing = Billings.new
  end

  def create
    @billing = Billings.new(billing_params)
    if @billing
      save_and_flash(@billing)
      redirect_to order_submit_path(session[:order_id])
      return
    else
      render :new, status: :bad_request
      return
    end
  end

  def edit
    find_billing
  end

  def update
    @billing.update_attributes(billing_params)
    if save_and_flash(@billing)
      redirect_to order_submit_path(session[:order_id])
      return
    else
      render :edit, status: :bad_request
      return
    end
  end
end

private
def billing_params
  return params.require(:order).permit(:cc_name, :email, :address, :zip, :cc_cvv, :cc_num, :cc_exp, :order_id)
end

def find_billing
  @billing = Billing.find_by(id: params[:id])
  unless @billing
    head :not_found
  end
end
