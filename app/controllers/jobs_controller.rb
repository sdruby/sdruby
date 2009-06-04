class JobsController < ApplicationController
  before_filter :require_login, :except => [:index, :show]

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
    @job = Job.find(params[:id])

    if @job.created_by?(current_user)
      render :action => 'edit'
    else
      redirect_to jobs_path
    end
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
    @job = Job.find(params[:id])

    if @job.created_by?(current_user)
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
    else
      redirect_to jobs_path
    end
  end

  def destroy
    @job = Job.find(params[:id])

    if @job.created_by?(current_user)
      @job.destroy

      respond_to do |format|
        format.html { redirect_to(jobs_url) }
        format.xml  { head :ok }
      end
    else
      redirect_to jobs_path
    end
  end

  private
  def require_login
    if current_user.nil?
      flash[:notice] = "Please login to post a job "
      redirect_to login_path
    end
  end
end
