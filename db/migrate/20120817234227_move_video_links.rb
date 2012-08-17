class MoveVideoLinks < ActiveRecord::Migration
  def up
    Podcast.all.each do |podcast|
      podcast.update_attribute(:movie_link, podcast.movie_link.gsub("http://sdruby.org", "http://video.sdruby.org"))
    end
  end

  def down
  end
end
