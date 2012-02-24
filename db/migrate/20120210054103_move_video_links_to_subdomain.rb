class MoveVideoLinksToSubdomain < ActiveRecord::Migration
  def up
    Podcast.all.each do |podcast|
      podcast.movie_link.gsub("http://sdruby.org", "http://video.sdruby.org")
    end
  end

  def down
    Podcast.all.each do |podcast|
      podcast.movie_link.gsub("http://video.sdruby.org", "http://sdruby.org")
    end
  end
end
