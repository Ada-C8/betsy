class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def confirm_login
    if session[:merchant].nil?
      flash[:status] = :failure
      flash[:message] = "You must be logged in to do that."
      return redirect_back(fallback_location: products_path)
    end
  end
end
