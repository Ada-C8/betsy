class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login]

  def login
    auth_hash = request.env['omniauth.auth']
    puts "In login action, auth_hash is #{auth_hash}"
    if auth_hash['uid']
      puts "Searching for merchant"
      merchant = Merchant.find_by(provider: params[:provider], uid: auth_hash['uid'])
      if merchant.nil?
        puts "Did not find merchant, creating new one."
        merchant = Merchant.from_auth_hash(params[:provider], auth_hash)
        save_and_flash(merchant) # in application_controller.rb
        puts "#{merchant.inspect}"
      else
        puts "Found merchant #{merchant.inspect}"
        flash[:status] = :success
        flash[:message] = "Logged in as returning user #{merchant.username}"
      end
      session[:merchant_id] = merchant.id
    else
      flash[:status] = :failure
      flash[:message] = "Could not create new user."
    end
    redirect_to root_path
  end

  def logout
    session[:merchant_id] = nil
    session[:order_id] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end
end
