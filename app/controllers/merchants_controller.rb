class MerchantsController < ApplicationController
  def login
    auth_hash = request.env['omniauth.auth']
    merchant = Merchant.find_by(oauth_uid: auth_hash['uid'], oauth_provider: auth_hash['provider'])

    if merchant
      flash[:status] = :success
      flash[:result_text] = "Successfully logged in "
    else
      merchant = Merchant.by_auth_hash(auth_hash)
      if merchant.save
        flash[:status] = :success
        flash[:result_text] = "Successfully created new merchant "
      else
        flash.now[:status] = :failure
        flash.now[:result_text] = "Not logged in"
        flash.now[:messages] = merchant.errors.messages
        return redirect_to root_path
      end
    end
    session[:merchant] = merchant
    redirect_to root_path
  end

  def logout
    session[:merchant] = nil
    redirect_to root_path
  end
  #CRUD

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)

    if @merchant.save
      #success message
      flash[:status] = :success
      flash[:message] = "Successfully created merchant #{@merchant.id}"
      redirect_to root_path
    else
      #I'm not sure how we're deciding to do error messages.  Flash?
      flash.now[:status] = :failure
      flash.now[:message] = "Failed to create Merchant"
      flash.now[:details] = @merchant.errors.messages
      render :new, status: :bad_request
    end
  end

  # def index
  #   @merchants = Merchant.all
  # end

  def edit
    @merchant = Merchant.find_by(id: params[:id])
    return head :not_found unless @merchant
  end

  def update
    if find_merchant_by_params_id
      @merchant.update_attributes(merchant_params)

      if @merchant.save
        flash[:status] = :success
        flash[:message] = "Successfully updated #{@merchant.username}"
        redirect_to merchant_path(@merchant)
        return

      else
        flash.now[:status] = :failure
        flash.now[:message] = "Could not update #{@merchant.username}"
        # flash.now[:messages] = @merchant.errors.messages
        render :edit, status: :bad_request
        # return
      end
    end
  end

  def show
    @merchant = Merchant.find_by(id: params[:id])
    return head :not_found unless @merchant
  end

  def destroy
    @merchant.destroy
    redirect_to root_path
  end


  private

  def merchant_params
    return params.require(:merchant).permit(:username, :email, :oauth_uid, :oauth_provider)
  end

  def find_merchant_by_params_id
    @merchant = Merchant.find_by(id: params[:id])
    unless @merchant
      head :not_found
    end
    return @merchant
  end

end
