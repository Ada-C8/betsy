class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_user

  def render_404
    render file: "/public/404.html", status: 404
  end

  # returns current user if already exists in session
  # else creates a new user and returns it
  def get_current_user
    if @auth_user
      return User.find_by(id: session[:user_id])
    else
      return User.create
    end
  end

  private

  def find_user
    if session[:user_id]
      @auth_user = Merchant.find_by(user_id: session[:user_id])
    end
  end
end
