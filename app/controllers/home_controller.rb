class HomeController < ApplicationController
  
  def index
    @podcast = Podcast.published.first
  end

end
