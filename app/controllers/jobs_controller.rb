class JobsController < ApplicationController
  before_filter :require_login, :except => [:index, :show]
  before_filter :load_job_and_authorize, :only => [:edit, :update, :destroy]

  def index
    @jobs = Job.published.newest_first
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def edit
    render :action => 'edit'
  end

  def create
    @job = current_user.jobs.build(params[:job])

    if @job.save
      flash[:notice] = 'Job was successfully created.'
      redirect_to(@job)
    else
      render :action => "new"
    end
  end

  def update
    if @job.update_attributes(params[:job])
      flash[:notice] = 'Job was successfully updated.'
      redirect_to(@job)
    else
      render :action => "edit"
    end
  end

  def destroy
    @job.destroy

    redirect_to(jobs_url)
  end

  private
  
  def require_login
    if current_user.nil?
      flash[:notice] = "Please login to post a job "
      redirect_to login_path
    end
  end

  def load_job_and_authorize
    @job = Job.find(params[:id])
    
    unless @job.created_by?(current_user)
      redirect_to jobs_path
      return false
    end
  end

end
