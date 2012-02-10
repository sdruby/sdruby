class Podcast < ActiveRecord::Base
  default_scope :order => "id DESC"

  scope :published, :conditions => {:publish => true}

  has_attached_file :screenshot,
                    :styles => {
                    :large => ["345x267!", :png],
                    :small => ["150x116!", :png] },
                    :path => ":rails_root/public/images/screenshots/:style/:id.:extension",
                    :url => "/images/:attachment/:style/:id.:extension",
                    :default_style => :large

  validates :name, :description, :movie_link, :presence => true

  validates_attachment_presence :screenshot, :message => "is missing"
  validates_attachment_content_type :screenshot,
                                    :content_type => ["image/jpeg", "image/jpg", "image/png", "image/gif"],
                                    :message => "must be a GIF, JPEG, or PNG"

  def episode_number
    "Episode %03d" % id
  end

  def movie_type
    return "video/mp4" if self.movie_link.match(/mp4/)
    return "video/x-m4v" if self.movie_link.match(/m4v/)
  end

end
