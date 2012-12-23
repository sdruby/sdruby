class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all # include all helpers, all the time

  helper_method :current_user_session, :current_user, :current_admin, :meetup, :next_event

  include Rack::Recaptcha::Helpers

  private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def current_admin
    current_user if current_user.try(:admin?)
  end

  def meetup
    @meetup ||= Meetup.new :sdruby
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_admin
    unless current_user and current_user.admin?
      store_location
      flash[:notice] = "You are not authorized to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to root_path
      return false
    end
  end

  def store_location
    session[:return_to] = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
