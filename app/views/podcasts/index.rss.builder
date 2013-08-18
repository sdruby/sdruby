title = "SD Ruby Podcast"
author = "SD Ruby"
email = 'sandiegoruby@gmail.com'
keywords = "ruby, rails, ruby on rails, programming, web, development, agile, railscast"
image = "http://sdruby.org/assets/application/logo_podcast.png"
description = "Watch awesome talks on Ruby, Ruby on Rails, and other topics in this long-running video podcast from the San Diego Ruby user group. This podcast features live talks from SD Ruby members which are recorded each month on the campus of the University of California San Diego, in the Computer Science and Engineering building. The SD Ruby podcast is sponsored by New Relic. Bandwidth is provided by Joyent."

xml.instruct! :xml, :version => "1.0"
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:atom" => "http://www.w3.org/2005/Atom",  :version => "2.0" do
  xml.channel do
    xml.title title
    xml.link 'http://sdruby.org'
    xml.description description
    xml.language 'en-us'
    xml.pubDate @podcasts.last.created_at.to_s(:rfc822)
    xml.lastBuildDate @podcasts.last.created_at.to_s(:rfc822)
    xml.itunes :author, author
    xml.itunes :image, :href => image
    xml.itunes :explicit, 'no'
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, email
    end
    xml.itunes :block, 'no'
    xml.itunes :category, :text => 'Technology' do
      xml.itunes :category, :text => 'Software How-To'
    end
    xml.itunes :category, :text => 'Education' do
      xml.itunes :category, :text => 'Training'
    end
    xml.tag! 'new-feed-url', "http://feed.sdruby.org/sdruby"
    xml.tag! 'atom:link', :href => "http://feed.sdruby.org/sdruby", :rel => "self", :type => "application/rss+xml"
    @podcasts.each do  |episode|
      xml.item do
        # Remove bonus links to slides since iTunes ignores them
        description = episode.description.split(/Bonus/)[0].split(/Here are the/)[0]
        
        # De-educate smart quotes since they can also cause problems
        description = description.gsub('&#8217;',"'")
        
        # Provide episode summary with encoded line breaks (for feed readers that support HTML)
        description = markdown(description)
        
        # Episode info
        xml.title "#{episode.episode_number}: #{episode.name}"
        xml.itunes :duration, episode.movie_duration.strip
        xml.itunes :image, :href => image
        xml.itunes :explicit, 'no'
        xml.itunes :keywords, keywords
        xml.itunes :summary, strip_tags(description) # plain text description for iTunes
        xml.description description                  # html description for feed readers
        xml.pubDate episode.created_at.to_s(:rfc822) # publish date for episode
        xml.enclosure :url => episode.movie_link, :type => episode.movie_type, :length => episode.movie_size
        xml.guid(podcast_url(episode))
      end
    end
  end
end
