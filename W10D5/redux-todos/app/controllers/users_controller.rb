class UsersController < ApplicationController
  before_action :redirect_if_logged_in

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to root_url
    else
      flash.now[:erros] = @user.errors
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end
end
