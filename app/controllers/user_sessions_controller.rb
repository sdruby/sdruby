class UserSessionsController < ApplicationController
  before_filter :require_not_logged_in, :only => [:new, :create]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])

    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default user_path(@user_session.user)
    else
      render :action => :new
    end
  end

  def destroy
    if current_user.nil?
      flash[:notice] = "You're already logged out!"
    else
      current_user_session.destroy
      flash[:notice] = "Logout successful!"
    end
    redirect_to root_path
  end


  private

  def require_not_logged_in
    if current_user
      redirect_to user_path(current_user)
      false
    end
  end
end

