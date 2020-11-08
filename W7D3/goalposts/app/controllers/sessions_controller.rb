class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user
      login!(user)
      flash[:success] = 'Successfully logged in'
      redirect_to user_url(user)
    else
      flash[:errors] = 'Invalid login'
      redirect_to new_session_url
    end
  end

  def destroy
    logout!
    flash[:success] = 'Successfully logged out'
    redirect_to new_session_url
  end
end
