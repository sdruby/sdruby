class HomeController < ApplicationController
  
  def index
    @podcast = Podcast.published.last
  end

end
