class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: %i[new create]

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
      flash.now[:errors] << 'not valid credentials'
      render :new
    end
  end

  def destroy
    logout
    flash[:errors] ||= []
    flash[:errors] << "You've been logged out"
    redirect_to new_session_url
  end

  def destroy_sessions
    return unless params[:sessions_to_destroy]
    
    flash[:errors] ||= []
    params[:sessions_to_destroy].each do |token|
      Session.find_by(session_token: token).destroy
    end

    flash[:errors] << params[:sessions_to_destroy].join(', ')\
      if params[:session_to_destroy]
    redirect_to session_url
  end
end
