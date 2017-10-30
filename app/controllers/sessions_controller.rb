class SessionsController < ApplicationController
  def login_form
  end

  def login
  end

  def create
    @auth_hash = request.env['omniauth.auth']

    @user = User.find_by(uid: @auth_hash['uid'], provider: @auth_hash['provider'])

    if @user
      @user.merchant_status = true
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      flash[:success] = "#{@user.name} is logged in"
    else
      @user = User.new uid: @auth_hash['uid'], provider: @auth_hash['provider'], name: @auth_hash['info']['nickname'], email: @auth_hash['info']['email']
      @user.merchant_status = true
    end
    if @user.save
      session[:user_id] = @user.id
      session[:user_name] = @user.name
      flash[:success] = "Welcome #{@user.name}"
    else
      flash[:error] = "Unable to save user!"
      redirect_to root_path, status: :bad_request
      return
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    flash[:status] = :success
    flash[:result_text] = "Successfully logged out"
    redirect_to root_path
  end

end
