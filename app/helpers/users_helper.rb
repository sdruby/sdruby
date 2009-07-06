module UsersHelper
  
  def iconify_and_link(links, options={})
    options[:separator] = "\n" if options[:separator].blank?
    links.split(options[:separator]).collect do |link|
      icon = String.new
      ['github','twitter','flickr','delicious','aim', 'digg', 'yelp', 'vimeo'].each do |service|
        if link.match(/#{service}/)
          icon += link_to(image_tag("application/social/#{service}_#{options[:size]}.png"), link)
        end
      end
      if icon.blank?
        icon += link_to(image_tag("application/social/web_#{options[:size]}.png"), link)
      end
      "<li>" + icon + " " + link_to(link, link) + "</li>"
    end.join "\n"
  end
  
  def show_github_projects_for(user)
    projects = String.new
    YAML::load(user.github_projects).sort.each do |repo, description|
      projects << "<li>"
      projects << link_to(repo, "http://github.com/#{user.github_username}/#{repo}")
      projects << "<span>" + description + "</span>"
      projects << "</li>\n"
    end
    return projects
  end

end
