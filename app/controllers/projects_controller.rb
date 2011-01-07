class ProjectsController < ApplicationController

  def index
    @projects = Project.all(:order => "name ASC", :include => :user)
    @users = User.all(:order => "full_name ASC", :include => :projects)
  end

end
