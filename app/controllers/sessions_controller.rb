# Responsible for user authentication.
class SessionsController < ApplicationController
  before_filter :redirect_if_signed_in, except: :destroy

  def new
  end

  def create
    user = User.find_by_login(params[:login])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in"
      redirect_to collections_path
    else
      flash[:alert] = "Incorrect login or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out"
    redirect_to root_path
  end


  private def redirect_if_signed_in
    if current_user
      redirect_to collections_path
    end
  end
end
