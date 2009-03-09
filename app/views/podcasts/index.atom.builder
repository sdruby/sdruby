atom_feed({:root_url => podcasts_url, :schema_date => 2006}) do |feed|
  feed.title "SD Ruby Podcast"
  feed.updated @podcasts.first.created_at
  @podcasts.each do |podcast|
    feed.entry(podcast) do |entry|
      entry.title   podcast.name
      entry.content textilize(("!#{request_host}/images/#{podcast.image}!\n\n#{podcast.description}")), :type => 'html'
      entry.author do |author|
        author.name "bob"
      end
    end
  end
end
