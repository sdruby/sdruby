class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  validates_length_of :full_name, :minimum => 2
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_length_of :password, :password_confirmation, :minimum => 4, :on => :create

  validate_on_create :passwords_are_equal
  validate :avatar_is_valid

  before_save :generate_salt, :generate_password_digest

  has_attached_file :avatar, 
                    :styles => { :small  => "48x48#", :medium  => "128x128#", :large  => "256x256#" }, 
                    :path => ":rails_root/public/images/users/avatars/:id/:style.:extension",
                    :url => "/images/users/avatars/:id/:style.:extension",
                    :default_url => "/images/users/avatar.gif"
                    
                    
  def is_admin?
    self.id == 1 ? true : false
  end

protected
  def avatar_is_valid
    if self.avatar_file_name?
      unless ["image/gif", "image/jpeg", "image/png"].include?(self.avatar_content_type)
        errors.add_to_base "Avatar must be a GIF, JPEG, or PNG"
      end
    end
  end

  def passwords_are_equal
    errors.add_to_base("Password confirmation must match Password.") unless self.password == self.password_confirmation
  end

  def generate_salt
    self.salt = String.random_alpha
  end

  def generate_password_digest
    self.password_digest = Digest::MD5.hexdigest(password + salt)
  end
end
