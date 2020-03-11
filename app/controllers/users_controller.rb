class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :delete]

  def index
    @my_products = Product.where(user_id: current_user)
    @products_sold = Purchase.where(user_id: current_user)
    @my_purchases = Purchase.where(buyer_id: current_user)
    @products_left = @my_products.where.not(id: @products_sold.select(:product_id))
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/shoes'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def require_correct_user
  user = User.find(params[:id])
  redirect_to current_user if current_user != user
  end
end
