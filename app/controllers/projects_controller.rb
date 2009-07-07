class ProjectsController < ApplicationController

  def index
    @users = User.all
    @projects = Array.new
    @users.each do |user|
      @projects << [YAML::load(user.github_projects), user]
    end
  end

end