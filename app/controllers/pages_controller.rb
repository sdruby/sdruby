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
    @team = User.where(:admin => true).order(:sort)
  end

  def thanks
  end

  def tshirts
  end

  def tutorial
  end

end
