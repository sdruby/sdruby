class Job < ActiveRecord::Base
  require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'helpers')
  belongs_to :user

  named_scope :published, :conditions => {:published => true}
  named_scope :newest_first, :order => 'created_at DESC'

  validates_presence_of :title, :description

  def age
    help.distance_of_time_in_words_to_now(created_at)
  end

  def created_by?(user)
    user && user_id == user.id
  end
end
