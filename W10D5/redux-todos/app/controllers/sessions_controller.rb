class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, except: :destroy

  def destroy
    logout!
    redirect_to new_session_url
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if @user
      login!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = ['Invalid credentials']
      render :new
    end
  end
end
