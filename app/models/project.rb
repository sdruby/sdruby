class Project < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name

  def self.featured
    random_method = connection.adapter_name == 'SQLite' ? 'RANDOM()' : 'RAND()'

    includes(:user)
    .where("github_watchers >= ? AND github_pushed_at >= ?", 5, 1.year.ago)
    .order(random_method)
    .first
  end
end
