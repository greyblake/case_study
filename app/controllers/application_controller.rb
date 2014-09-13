class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Get and instance of the current user.
  #
  # @return [User, nil]
  private def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find(session[:user_id])
  end
  helper_method :current_user
end
