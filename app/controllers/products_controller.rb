class ProductsController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @my_purchases = Purchase.select(:product_id)
    @products = Product.where.not(id: @my_purchases)
  end

  def create
    @user = User.find(current_user)
  	@product = Product.new(product_params)
    if @product.save
      redirect_to "/dashboard/#{@user.id}"
    else
      flash[:errors] = @product.errors.full_messages
      redirect_to :back
    end
  end

  def buy
    @user = User.find(session[:user_id])
  	@purchase = Purchase.new(purchase_params)
    if @purchase.save
      redirect_to "/dashboard/#{@user.id}"
    else
      flash[:errors] = @purchase.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @user = User.find(current_user)
    @product = Product.find(params[:id])
    @product.destroy if @product.user === current_user
    redirect_to "/dashboard/#{@user.id}"
  end

  private
  def product_params
    params.require(:product).permit(:product_name, :amount).merge(user: current_user)
  end

  def purchase_params
    params.require(:purchase).permit(:user_id, :buyer_id, :product_id)
  end

end
