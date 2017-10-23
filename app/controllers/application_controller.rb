class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected
  def require_login
    @login_user = Merchant.find_by(id: session[:merchant_id])
    unless @login_user
      flash[:status] = :failure
      flash[:message] = "You must be logged in to do that!"
      redirect_to root_path
    end
  end

  def save_and_flash(model)
    result = model.save

    if result
      flash[:status] = :success
      flash[:message] = "Successfully created a new Satiety account for #{model.username}." # this is the message that appears when a person logs in with GitHub for the first time
    else
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to save #{model.class}."
      flash.now[:details] = model.errors.messages
    end

    return result
  end
end
