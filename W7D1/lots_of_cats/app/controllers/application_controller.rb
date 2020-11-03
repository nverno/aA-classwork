class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  # CRLLL methods
  def current_user
    @current_user ||=
      Session.find_by(session_token: session[:session_token])&.user
  end

  def redirect_if_logged_in
    redirect_to cats_url if logged_in?
  end

  def logout
    Session.find_by(session_token: session[:session_token]).destroy
    session[:session_token] = nil
    @current_user = nil
  end

  def logged_in?
    !!current_user
  end

  def login(user)
    session[:session_token] = user.reset_session_token(session[:session_token])
  end
end
