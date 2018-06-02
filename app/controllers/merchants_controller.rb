class MerchantsController < ApplicationController

  before_action :confirm_login, only: [:summary, :pending, :completed, :mark_shipped, :revenue, :inventory]

  before_action only: [:mark_shipped] do
    @order_product = find_object_by_params(OrderProduct)
  end

  before_action only: [:mark_shipped] do
    confirm_object_ownership(@order_product, @order_product.product.merchant_id)
  end


  def login
    auth_hash = request.env['omniauth.auth']
    merchant = Merchant.find_by(oauth_uid: auth_hash['uid'], oauth_provider: auth_hash['provider'])

    unless merchant
      merchant = Merchant.by_auth_hash(auth_hash)
      unless merchant.save
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

  # def new
  #   @merchant = Merchant.new
  # end

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
    @merchant = Merchant.find_by(id: params[:id])
    @merchant.destroy
    redirect_to root_path
  end

  # USER PAGES
  def summary
    @user = Merchant.find(session[:merchant]['id'])
  end

  def pending
    @order_products = Merchant.find(session[:merchant]['id']).pending_orders
  end

  def completed
    @order_products = Merchant.find(session[:merchant]['id']).shipped_orders
  end

  def mark_shipped
    order_product = OrderProduct.find_by(id: params[:id])
    if order_product
      order_product.status = "shipped"
      order_product.save
      order_product.order.order_status
      flash[:status] = :success
      flash[:message] = "Marked #{order_product.product.name} as shipped"
      return redirect_to self_pending_path
    else
      return head :not_found
    end
  end

  def revenue
    @user = Merchant.find(session[:merchant]['id'])
    @all = @user.own_orders
    @pending = @user.pending_orders
    @completed = @user.shipped_orders
    @all_average = (@all.count == 0 ? 0 : (@all.sum{|order| order.total})/@all.count)
    @pending_average = (@pending.count == 0 ? 0 : (@pending.sum{|order| order.total})/@pending.count)
    @completed_average = (@completed.count == 0 ? 0 : (@completed.sum{|order| order.total})/@completed.count)
  end

  def inventory
    merchant = Merchant.find(session[:merchant]['id'])
    @products = merchant.active_products
    @inactive_products = merchant.inactive_products
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
