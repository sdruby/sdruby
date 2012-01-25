require 'metadata'
class AddLengthToExisting < ActiveRecord::Migration
  def self.up
    if `which mplayer`.empty?
      puts "You need mplayer to read the metadata, skipping"
      return
    end
    Dir.glob(File.join(Rails.root, "public", "video", "*.m4v")).each do |file|

      file_data = Metadata.get(file)
      duration =  file_data[:LENGTH].to_f
      duration = 5000
      minutes = (duration / 60).to_i
      seconds = duration - (minutes * 60)
      seconds = seconds.to_i
      file_size = File.size(file)

      podcast = Podcast.find(:first, :conditions => ["movie_link = ?", "http://sdruby.com/video/#{File.basename(file)}"])
      next unless podcast

      podcast.movie_duration = "#{minutes}:#{seconds}"
      podcast.movie_size = file_size
      podcast.save
    end

  end

  def self.down
  end
end
