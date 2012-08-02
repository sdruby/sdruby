class PagesController < ApplicationController
  
  def about
  end
  
  def index
    @podcast = Podcast.published.first
  end
  
  def speak
  end
  
  def sponsors
  end
  
  def team
    @organizer = User.find_by_full_name("Patrick Crowley")
    @team = User.where(:admin => true).order(:sort)
  end
  
  def thanks
  end
  
  def tshirts
  end
  
end
