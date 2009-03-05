class Podcast < ActiveRecord::Base
  validates_presence_of :name, :description, :movie_link, :number

end
