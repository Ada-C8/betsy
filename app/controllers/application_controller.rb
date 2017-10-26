class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :no_nil_cart

  protected

  def no_nil_cart
    session[:cart] ||= []
  end

  def confirm_login
    if session[:merchant].nil?
      flash[:status] = :failure
      flash[:message] = "You must be logged in to do that."
      return redirect_back(fallback_location: root_path)
    end
  end

  def find_object_by_params(model)
    @product = model.find_by(id: params[:id])
    unless @product
      return head :not_found
    end
    return @product
  end

  def confirm_object_ownership(model, merchant_id)
    unless session[:merchant]['id'] == merchant_id
      flash[:status] = :failure
      flash[:message] = "Only a #{model}'s creator can modify a #{model}."
      return redirect_back(fallback_location: root_path)
    end
  end


end
