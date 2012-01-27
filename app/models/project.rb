class Project < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name
  
  if self.connection.is_a? (ActiveRecord::ConnectionAdapters::SQLite3Adapter)
    def self.featured
      first(
        :include => :user, 
        :conditions => ["github_watchers >= ? AND github_pushed_at >= ?", 5, 12.months.ago],
        :order => "RANDOM()"
      )
    end
  else
    def self.featured
      first(
        :include => :user, 
        :conditions => ["github_watchers >= ? AND github_pushed_at >= ?", 5, 12.months.ago],
        :order => "RAND()"
      )
    end
  end

end
