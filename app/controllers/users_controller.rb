class UsersController < ApplicationController
  # before_filter :require_user #TODO remove this once user creation is working
  def new
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
    
end
