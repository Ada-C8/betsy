class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login]

  def login
    auth_hash = request.env['omniauth.auth']

    if auth_hash['uid']
      user = Merchant.find_by(provider: params[:provider], uid: auth_hash['uid'])
      unless user
        # user has not logged in before
        user = Merchant.from_auth_hash(auth_hash)
      end

      session[:user_id] = merchant.id]
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
          session[:merchant_id] = merchant.id
        else
          flash[:status] = :error
          flash[:result_text] = "Something went wrong!"
          render "login", status: :bad_request
          return
        end
      end
      redirect_to root_path
      return
    end

    def logout
      session[:merchant_id] = nil
      flash[:status] = :success
      flash[:result_text] = "Successfully logged out"

      redirect_to root_path
    end
  end
