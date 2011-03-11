class Project < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name
  
  def self.featured
    first(
      :include => :user, 
      :conditions => ["github_watchers >= ? AND github_pushed_at >= ?", 10, 6.months.ago],
      :order => "RAND()"
    )
  end

end
