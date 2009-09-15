atom_feed({:root_url => podcasts_url, :schema_date => 2006}) do |feed|
  feed.title "SD Ruby Podcast"
  feed.updated @podcasts.first.created_at
  @podcasts.each do |podcast|
    feed.entry(podcast) do |entry|
      entry.title   "#{podcast.episode_number}: #{podcast.name}"
      entry.content markdown(("!#{request_host}#{podcast.screenshot.url}!\n\n#{podcast.description}\n\n#{link_to podcast.movie_link, podcast.movie_link}")), :type => 'html'
      entry.author do |author|
        author.name "SD Ruby"
      end
    end
  end
end
