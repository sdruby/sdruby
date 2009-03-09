class LegacyPodcast < LegacyBase
  set_table_name "contents"

  def map
    {
      :name => self.title.gsub(/Episode [0-9]*\: /,''),
      :description => clean_up_description(self.body.strip),
      :movie_link => self.body.match(/http:\/\/podcast.sdruby.com\/podcasts\/.*\.(m4v|mp4)/)[0],
      :old_permalink => self.permalink,
      :created_at => self.published_at,
      :updated_at => self.published_at,
      :screenshot => File.open("public/images/episodes/#{self.id}.png"),
      :publish => true
    }
  end
  
  def clean_up_description(text)
    text = text.gsub(/"!\/images\/articles\/screenshot_[0-9]*\.(png|jpg|gif)!"/,'')
    text = text.gsub(/"!http:\/\/podcast.sdruby.com\/images\/articles\/screenshot_[0-9]*\.(png|jpg|gif)!"/,'')
    text = text.gsub(/:http:\/\/podcast.sdruby.com\/podcasts\/.*\.(m4v|mp4)/,'')
  end
                  
end
