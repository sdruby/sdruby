class Project < ActiveRecord::Base
  belongs_to :user, counter_cache: true

  validates :name, :presence => :true

  def self.featured
    random_method = connection.adapter_name == 'MySQL' ? 'RAND()' : 'RANDOM()'

    includes(:user)
    .where("github_watchers >= ? AND github_pushed_at >= ?", 5, 1.year.ago)
    .order(random_method)
    .first
  end
end
