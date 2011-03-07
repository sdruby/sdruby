namespace :projects do

  desc "Updates list of Github projects for each SD Ruby member"
  task :update => :environment do
    
    User.all.each_with_index do |user,index|
      puts "Updating projects for github.com/#{user.github_username} (#{user.full_name})"
      user.grab_projects
    end

  end

end