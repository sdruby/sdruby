require "hpricot"
require "open-uri"

class User < ActiveRecord::Base
  has_many :projects, :order => "github_created_at DESC"

  acts_as_authentic

  validates :full_name, :length => { :minimum => 2 }
  validates :email, :uniqueness => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }

  validate :avatar_is_valid

  has_attached_file :avatar, 
                    :styles => { :small  => "48x48#", :medium  => "128x128#", :large  => "256x256#" }, 
                    :path => ":rails_root/public/images/users/avatars/:id/:style.:extension",
                    :url => "/images/users/avatars/:id/:style.:extension",
                    :default_url => "/images/users/avatar_:style.png"
               
  def to_s
    full_name
  end
         
  def is_admin?
    self.id == 1 ? true : false
  end

  def first_name
    full_name.split(' ').first
  end

  def last_name
    full_name.split(' ')[1..-1].join(" ")
  end

  def grab_projects
    unless self.github_username.blank?
      
      # Destroy existing projects
      self.projects.destroy_all
      
      # Grab new projects
      begin
      doc = Hpricot.XML(open("http://github.com/api/v2/xml/repos/show/#{self.github_username.strip}/"))

      (doc/:repositories).each do |repository|
        (repository/:name).each_with_index do |name, index|
          unless (repository/:fork)[index].try(:inner_html) == 'true'
            self.projects << Project.new(:name => name.inner_html,
                                         :description => (repository/:description)[index].inner_html,
                                         :github_created_at => (repository/"created-at")[index].inner_html,
                                         :github_pushed_at => (repository/"pushed-at")[index].inner_html,
                                         :github_watchers => (repository/"watchers")[index].inner_html                                   
                                         )
          end
        end
      end
      rescue Exception => e#if no projects are found
        Rails.logger.error(e.inspect)
      end
    else
      # Destroy existing projects (if github username is blank)
      self.projects.destroy_all
    end
  end

  protected
  
  def avatar_is_valid
    if self.avatar_file_name?
      unless ["image/gif", "image/jpeg", "image/png"].include?(self.avatar_content_type)
        errors.add_to_base "Avatar must be a GIF, JPEG, or PNG"
      end
    end
  end
  
end
