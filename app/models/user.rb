require 'net/http'
require "open-uri"

class User < ActiveRecord::Base
  has_many :projects, :order => "github_created_at DESC"

  acts_as_authentic

  validates :full_name, :length => { :minimum => 2 }
  validates :email, :uniqueness => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validate :avatar_is_valid

  searchable do
    text :about, :email, :full_name, :github_username, :neighborhood
    boolean :available_for_work
  end

  if ['production', 'staging'].include?(Rails.env)
    has_attached_file :avatar,
      styles: { :small  => "48x48#", :medium  => "128x128#", :large  => "256x256#" },
      storage: :s3,
      s3_credentials: {
        access_key_id: APP_CONFIG["AWS_ACCESS_KEY_ID"],
        secret_access_key: APP_CONFIG["AWS_SECRET_ACCESS_KEY"]
      },
      s3_protocol: "http",
      s3_permissions: "public_read",
      bucket: APP_CONFIG["AWS_BUCKET"],
      path: "avatars/:id/:style.:extension",
      url: "/avatars/:id/:style.:extension",
      default_style: :large
  else
    has_attached_file :avatar,
                      :styles => { :small  => "48x48#", :medium  => "128x128#", :large  => "256x256#" },
                      :path => ":rails_root/public/images/users/avatars/:id/:style.:extension",
                      :url => "/images/users/avatars/:id/:style.:extension"
  end

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
    unless github_username.blank?
      # Destroy existing projects
      projects.destroy_all

      # Grab new projects
      begin
        api_uri = URI("https://api.github.com/users/#{github_username.strip}/repos")
        api_session = Net::HTTP.new api_uri.host, api_uri.port
        api_session.use_ssl = true

        repos = JSON.parse(api_session.request(Net::HTTP::Get.new(api_uri.request_uri)).body)
        repos.each do |repo|
          next if repo['fork']
          projects.create( :name               => repo['name'],
                           :description        => repo['description'],
                           :github_created_at  => repo['created_at'],
                           :github_pushed_at   => repo['pushed_at'],
                           :github_watchers    => repo['watchers'] )
        end
      rescue Exception => e #if no projects are found
        Rails.logger.error(e.inspect)
      end
    else
      # Destroy existing projects (if github username is blank)
      projects.destroy_all
    end
  end

  def send_new_password
    new_pass = User.random_string(10)
    self.password = self.password_confirmation = new_pass
    self.save

    UserMailer.forgot_password(self.email, new_pass).deliver
  end

  def twitter
    handle = nil
    if self.links
      self.links.split("\n").each do |link|
        if link.match('twitter')
          handle = link.split(/\//)[-1]
        end
      end
      if handle != nil
        return handle
      else
        return false
      end
    else
      return false
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

  def self.random_string(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

end
