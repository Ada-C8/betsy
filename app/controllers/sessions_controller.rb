class SessionsController < ApplicationController
  def create
    @auth_hash = request.env['omniauth.auth']

    @merchant = Merchant.find_by(uid: @auth_hash['uid'], provider: @auth_hash['provider'])

    if @merchant
      session[:user_id] = @merchant.id
      flash[:result_text] = "Welcome back #{@merchant.username}"
    else
      @merchant = Merchant.new(uid: @auth_hash['uid'], provider: @auth_hash['provider'], username: @auth_hash['info']['nickname'], email: @auth_hash['info']['email'])
      if @merchant.save
        session[:user_id] = @merchant.id
        flash[:status] = :success
        flash[:result_text] = "Welcome to Sourceress, #{@merchant.username}"
      else
        flash[:result_text] = "Unable to save user!"
      end
    end
    redirect_to home_path
  end

def logout
  session[:user_id] = nil
  session[:order_id] = nil
  flash[:status] = :success
  flash[:result_text] = "Successfully logged out!"
  redirect_to home_path
end

end
