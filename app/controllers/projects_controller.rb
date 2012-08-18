class ProjectsController < ApplicationController

  def index
    @projects = Project.all(:order => "name ASC", :include => :user)
    @featured_project = Project.featured
    @users = User.all(:order => "full_name ASC", :include => :projects)
  end

  def featured
    @featured_project = Project.featured
    render :partial => "project"
  end

end
