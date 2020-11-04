class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )

    if @user&.save
      login!(@user)
      flash[:errors] = ["Successfully logged in as #{@user.email}"]
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to new_user_url
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
