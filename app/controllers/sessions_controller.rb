class SessionsController < ApplicationController
  # skip_before_action :require_login, only: [:login]

  def login
    auth_hash = request.env['omniauth.auth']
    if auth_hash['uid']
      merchant = Merchant.find_by(provider: params[:provider], uid: auth_hash['uid'])
      if merchant.nil?
        merchant = Merchant.from_auth_hash(params[:provider], auth_hash)
        save_and_flash(merchant)

      else
        flash[:status] = :success
        flash[:message] = "Successfully logged in as returning user #{merchant.username}"

      end
      session[:merchant_id] = merchant.id

    else
      flash[:status] = :failure
      flash[:message] = "Could not create user from OAuth data"
    end

    redirect_to root_path
  end

  def index
    @user = User.find(session[:user_id])
  end

  def logout
    session[:merchant_id] = nil
    flash[:status] = :success
    flash[:message] = "You have been logged out"
    redirect_to root_path
  end
end
