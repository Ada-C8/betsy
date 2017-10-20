class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      merchant = Merchant.find_by(uid: auth_hash[:uid], provider: 'github')
      if merchant.nil?
        # Merchant doesn't match anything in the DB
        # Attempt to create a new merchant
        merchant = Merchant.build_from_github(auth_hash)
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
