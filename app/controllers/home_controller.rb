class HomeController < ApplicationController
  
  def index
    @podcast = Podcast.find(:last)
  end

end
