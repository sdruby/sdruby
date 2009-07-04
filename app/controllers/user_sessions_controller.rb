class UserSessionsController < ApplicationController
  before_filter :require_not_logged_in, :only => [:new, :create]
  before_filter :require_login, :only => :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to root_path
  end

  private
  def require_login
    if current_user.nil?
      flash[:notice] = "You're already logged out!"
      redirect_to root_path
    end
  end

  def require_not_logged_in
    if current_user
      redirect_to account_path
    end
  end
end

