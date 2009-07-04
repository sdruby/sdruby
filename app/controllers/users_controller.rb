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
    respond_to do |format|
      format.html
      format.xml  { render :xml => @user }
    end
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        flash[:notice] = 'User was successfully created.'
        format.html { redirect_to(@user) }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    unless @user = User.find_by_id(params[:id])
      respond_to do |format|
        format.html do
          flash[:notice] = "No such user."
          redirect_to root_path
        end
        format.xml do
          render :xml => '<?xml version="1.0" encoding="UTF-8"?><errors><error>' +
                         'User Not Found</error></errors>', :status => :unprocessable_entity
        end
      end
    else
      respond_to do |format|
        format.html
        format.xml  { render :xml => @user.to_xml }
      end
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
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
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
