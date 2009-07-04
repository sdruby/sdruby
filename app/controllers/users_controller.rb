class UsersController < ApplicationController
  # before_filter :require_user #TODO remove this once user creation is working
  before_filter :require_login, :only => [:show, :edit, :update]
  before_filter :authorize, :only => [:edit, :update]

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
    @user = current_user
    respond_to do |format|
      format.html
      format.xml  { render :xml => @user.to_xml }
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
  def require_login
    if current_user.nil?
      redirect_to login_path
    end
  end

  def authorize
    unless current_user.id == params[:id].to_i
      flash[:error] = "You are not authorized to edit this resource"
      redirect_to root_path
    end
  end
end
