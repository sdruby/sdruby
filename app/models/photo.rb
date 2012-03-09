class Photo 

  def self.meetup
    RMeetup::Client.api_key = '28593fc521913722bc11a60253a29'
    results = RMeetup::Client.fetch(:photos,{:group_urlname => 'sdruby'})

    images = Array.new
    results.each do |result|
      result.photo_urls.each do |photo|
        images << photo
      end
    end
    return images
  end

end
