class PhotosController < ApplicationController

  def index
    @photos = meetup.photos.map(&:photo_urls).flatten
  end
end
