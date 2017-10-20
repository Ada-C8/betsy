class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

<<<<<<< HEAD
=======
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  protected

  def confirm_login
    if session[:merchant].nil?
      flash[:status] = :failure
      flash[:message] = "You must be logged in to do that."
      return redirect_back(fallback_location: products_path)
    end
  end
>>>>>>> 8a8fabd4d3ac6d7fe0012efd4bc3ab4e32c08031
end
