class UsersController < ApplicationController
  before_filter :require_user, :except => [:index, :show, :new, :create, :forgot_password, :search]
  before_filter :find_user, :except => [:index, :new, :create, :forgot_password, :search]
  before_filter :authorize_user, :except => [:index, :show, :new, :create, :forgot_password, :search]

  def index
    @users = User.all(:order => "full_name ASC")
  end

  def new
    if current_user
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(params[:user])
    @user.valid?

    if !Rails.env.test? and !recaptcha_valid?
      @user.errors.add(:base, "You did not enter the correct words. Please try again.")
      render :action => "new"
    elsif @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to(@user)
    else
      render :action => "new"
    end
  end

  def forgot_password
    @user = User.new(params[:user])
    if request.post?
      u = User.find_by_email(params[:user][:email])
      if u and u.send_new_password
        current_user_session.destroy
        flash[:notice] = "We just sent you a new password. Check your email!"
        redirect_to login_path
      else
        flash.now[:notice] = "Your email is invalid. Please try again."
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:notice] = 'User was successfully updated.'
      @user.grab_projects
      @user.save
      @user.reload
      redirect_to(@user)
    else
      render :action => "edit"
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "Member profile deleted."

    redirect_to users_path
  end

  def search
    search = User.search do
      fulltext params[:q]
    end

    @users = search.results.sort{ |a,b| a.full_name <=> b.full_name }
    respond_to do |format|
      format.html
      format.json { render json: @users, only: :id }
    end
  end

  protected

  def find_user
    @user = User.find_by_id(params[:id])

    unless @user
      flash[:notice] = "No such user."
      redirect_to root_path
      return false
    end
  end

  def authorize_user
    unless current_admin or current_user == @user
      flash[:notice] = "You are you not authorized to manage this user."
      redirect_to users_path
      return false
    end
  end
end
