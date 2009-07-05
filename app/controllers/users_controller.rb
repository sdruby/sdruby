class UsersController < ApplicationController
  # before_filter :require_user #TODO remove this once user creation is working
  before_filter :require_login_and_authorize, :only => [:edit, :update]

  def index
    @users = User.all(:order => "full_name")
  end
  
  def new
    if current_user
      redirect_to account_path
      return
    end
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to(@user)
    else
      render :action => "new"
    end
  end

  def show
    unless @user = User.find_by_id(params[:id])
      flash[:notice] = "No such user."
      redirect_to root_path
    end
  end

  def edit
    @user = current_user
  end

  def edit_profile #TODO check if we're using this
    edit
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      redirect_to(@user)
    else
      render :action => "edit"
    end
  end

  private
  def not_logged_in
    current_user.nil?
  end

  def unauthorized
    !(current_user.id == params[:id].to_i)
  end

  def require_login_and_authorize
    if not_logged_in
      redirect_to(login_path)
    elsif unauthorized
      flash[:error] = "You are not authorized to edit this resource"
      redirect_to(root_path)
    end
  end
end
