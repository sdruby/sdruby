class HomeController < ApplicationController
  
  def index
    @podcast = Podcast.published.find(:last)
  end

end
