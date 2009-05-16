class User < ActiveRecord::Base
  acts_as_authentic

  validates_length_of :full_name, :minimum => 2
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validate :avatar_is_valid

  has_attached_file :avatar, 
                    :styles => { :small  => "48x48#", :medium  => "128x128#", :large  => "256x256#" }, 
                    :path => ":rails_root/public/images/users/avatars/:id/:style.:extension",
                    :url => "/images/users/avatars/:id/:style.:extension",
                    :default_url => "/images/users/avatar.gif"
                    
                    
  def is_admin?
    self.id == 1 ? true : false
  end

  def first_name
    full_name.split(' ').first
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
