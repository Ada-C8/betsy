class SessionsController < ApplicationController

  #TODO: REFACTOR FLASHES INTO THE APPLICATIONS CONTROLLER
  #TODO: CHECK AUTH HASH IN INTERACTIVE SHELL


  def login_form
  end

  def login
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      merchant = Merchant.find_by(provider: params[:provider], uid: auth_hash['uid'])
      if merchant.nil?
        merchant = Merchant.from_auth_hash(params[:provider], auth_hash)
        save_and_flash(merchant)
      else
        flash[:status] = :success
        flash[:message] = "Welcome back, #{merchant.username}"
      end
      session[:merchant_id] = merchant.id
      session[:merchant_username] = merchant.username
      #will log in the user
    else
      flash[:status] = :failure
      flash[:message] = "Could not create user from OAuth processes"
    end

    redirect_to root_path
  end



  # session[:merchant_id] = merchant.id
  # flash[:status] = :failure
  # flash[:message] = "Could not log in! Please try again."
  # flash[:errors] = merchant.errors.messages
  # session[:merchant_id] = merchant.id
  # flash[:status] = :success
  # flash[:message] = "Welcome back #{merchant.name}"

  def logout
    session[:merchant_id] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out!"

    redirect_to root_path
  end

end
