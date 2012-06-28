class PhotosController < ApplicationController
  
  def index
    @photos = Photo::meetup
  end
end
