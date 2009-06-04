class JobsController < ApplicationController
  before_filter :require_login, :except => [:index, :show]
  before_filter :load_job_and_authorize, :only => [:edit, :update, :destroy]
  def index
    @jobs = Job.published.newest_first

    respond_to do |format|
      format.html
      format.xml  { render :xml => @jobs }
    end
  end

  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html
      format.xml  { render :xml => @job }
    end
  end

  def new
    @job = Job.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @job }
    end
  end

  def edit
    render :action => 'edit'
  end

  def create
    @job = current_user.jobs.build(params[:job])

    respond_to do |format|
      if @job.save
        flash[:notice] = 'Job was successfully created.'
        format.html { redirect_to(@job) }
        format.xml  { render :xml => @job, :status => :created, :location => @job }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @job.update_attributes(params[:job])
        flash[:notice] = 'Job was successfully updated.'
        format.html { redirect_to(@job) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @job.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @job.destroy

    respond_to do |format|
      format.html { redirect_to(jobs_url) }
      format.xml  { head :ok }
    end
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
    end
  end

end
