class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])

    if @user
      login(@user)
      redirect_to cats_url
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << "not valid credentials"
      render :new
    end
  end

  def destroy
    logout
    flash[:errors] ||= []
    flash[:errors] << "You've been logged out"
    redirect_to new_session_url
  end
end
