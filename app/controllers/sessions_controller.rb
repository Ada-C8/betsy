class SessionsController < ApplicationController
  def login_form
    # keep empty
    ##### ask why! #####
  end

  def login
    @merchant = Merchant.new
  end

  def create
    username = params[:username]
    if username && merchant = Merchant.find_by(username: params[:username])
      # log em in
      session[:merchant_id] = merchant.id
      flash[:status] = :success
      #congratulate them for logging in
      flash[:result_text] = "Successfully logged in"
    else
     # no user, try to save
      merchant = Merchant.new(username: params[:username])
      if merchant.save
        # successful save
        flash[:status] = :success
        flash[:result_text] = "Successfully created new user!"
      #   session[:merchant_id] = merchant.id
      # else
      #   flash[:status] = :error
      #   flash[:result_text] = "Something went wrong!"
      #   render "login", status: :bad_request
      end
    end
    redirect_to root_path
  end

  def logout
    session[:merchant_id] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"

    redirect_to root_path
  end
end
