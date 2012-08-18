module PodcastsHelper

  def size_for(podcast)
    if podcast.id > 40
      "345x267"
    else
      "345x266"
    end
  end

end
