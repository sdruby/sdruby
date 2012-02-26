class PagesController < ApplicationController
  
  def about
  end
  
  def index
    @podcast = Podcast.published.first
  end
  
  def sponsors
  end
  
  def thanks
  end
  
  def tshirts
  end
  
end
