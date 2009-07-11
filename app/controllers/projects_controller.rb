class ProjectsController < ApplicationController

  def index
    @projects = Project.find(:all, :order => "name ASC")
    @users = User.find(:all, :order => "full_name ASC")
  end

end