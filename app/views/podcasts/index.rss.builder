title = "SD Ruby Podcast"
author = "SD Ruby"
email = 'patrick@mokolabs.com'
description = "SD Ruby. We are San Diego's Ruby community."
keywords = "ruby, rails, ruby on rails, programming, web, development, agile, railscast"
image = "http://sdruby.com/images/application/logo_podcast.jpg"

xml.instruct! :xml, :version => "1.0" 
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/",  :version => "2.0" do
  xml.channel do 
    xml.title title
    xml.link 'http://sdruby.com'
    xml.description description
    xml.language 'en-us'
    xml.pubDate @podcasts.first.created_at.to_s(:rfc822)
    xml.lastBuildDate @podcasts.first.created_at.to_s(:rfc822)
    xml.itunes :author, author
    xml.itunes :keywords, keywords
    xml.itunes :image, :href => image
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
    
    @podcasts.each do  |podcast|
      xml.item do
        xml.title "#{podcast.episode_number}: #{podcast.name}"
        xml.description markdown(("!#{request_host}#{podcast.screenshot.url}!\n\n#{podcast.description}")), :type => 'html'
        xml.pubDate podcast.created_at.to_s(:rfc822)
        xml.enclosure :url => podcast.movie_link, :type => podcast.movie_type, :length => podcast.movie_size
        xml.link podcast_url(podcast)
        xml.guid({:isPermaLink => "false"}, podcast_url(podcast))
        xml.itunes :summary, strip_tags(textilize(("!#{request_host}#{podcast.screenshot.url}!\n\n#{podcast.description}"))).gsub('&#8217;',"'")
        xml.itunes :explicit, 'no'
        xml.itunes :duration, podcast.movie_duration.strip
        # xml.itunes :author, author
      end
    end
  end
end
