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
        flash[:result_text] = "Successfully created new merchant_params "
      else
        flash.now[:status] = :failure
        flash.now[:result_text] = " Could not logged in"
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
      redirect_to root_path
    else
      #I'm not sure how we're deciding to do error messages.  Flash?
      render :new
    end
  end

  def index
    @merchants = Merchant.all
  end

  def edit
     @merchant = Merchant.find(params[:id])
     render_404 unless @merchant
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.save
      redirect_to merchant_path(@merchant)
      #success message
    else
      render :edit, status: :bad_request
      return
      #fail message flash
    end
  end

  def show
    @merchant = Merchant.find_by(id: params[:id])
    render_404 unless @merchant
  end

  def destroy
    @merchant.destroy
    redirect_to root_path
  end


  private

  def merchant_params
    return params.require(:merchant).permit(:username, :email, :oauth_uid, :oauth_provider)
  end
end
