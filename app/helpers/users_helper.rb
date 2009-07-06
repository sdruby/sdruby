module UsersHelper
  
  def linkify(str, separator = "\n")
    str.split(separator).collect {|link| link_to link, link}.join '<br />'
  end
  
  def show_github_projects_for(user)
    projects = String.new
    YAML::load(user.github_projects).each do |project|
      projects << "<li>" + project[0] + " &mdash; " + project[1] + "</li>\n"
    end
    return projects
  end

end
