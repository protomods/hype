class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login, :create]

  def login

  end

  def create
    @user = User.find_by_email(params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to '/shoes'
    else
      flash[:errors] = ["Invalid Combination"]
      redirect_to :back
    end
  end

  def logout
    session['user_id'] = nil
    redirect_to '/'
  end

end
