class MerchantsController < ApplicationController
  def login
    auth_hash = request.env['omniauth.auth']
  end

  def logout
    session[:merchant_id] = nil
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
