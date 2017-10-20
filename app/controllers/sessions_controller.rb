class SessionsController < ApplicationController
  def login
    auth_hash = request.env['omniauth.auth']
    if auth_hash['uid']
      merchant = Merchant.find_by(provider: params[:provider], uid: auth_hash['uid'])
      if merchant.nil?
        merchant = Merchant.from_auth_hash(params[:provider], auth_hash)
        save_and_flash(merchant)
      else
        flash[:success] = "Logged in successfully"
        redirect_to root_path
      end

      # If we get here, we have the merchant instance
      session[:merchant_id] = merchant.id
    else
      flash[:error] = "Could not log in"
      redirect_to root_path
    end
  end

  def index
    @merchant = Merchant.find(session[:merchant_id]) # < recalls the value set in a previous request
  end
end
