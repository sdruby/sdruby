class ConvertPodcastToMarkdown < ActiveRecord::Migration
  # Convert Textile links to Markdown links
  def self.up
    Podcast.find(:all).each do |podcast|
      podcast.description = podcast.description.gsub(/\"([\w ]*)\"\:(\S+)/, ('[\1](\2)'))
      podcast.save
    end
  end

  def self.down
    # Convert Markdown links to Textile links
    Podcast.find(:all).each do |podcast|
      podcast.description = podcast.description.gsub(/\[([\w ]*)\]\((\S+)\)/, ('"\1":\2'))
      podcast.save
    end
  end
end
