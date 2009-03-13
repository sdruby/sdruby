class PodcastsController < ApplicationController
  before_filter :require_user, :except => :index
  def index
    @podcasts = Podcast.find(:all, :order => "id DESC")
    respond_to do |format|
      format.html do
        @podcast = @podcasts.shift
        @years = @podcasts.collect { |episode| episode.created_at.strftime('%Y') }.uniq
      end
      format.atom
    end
  end

  def show
    @podcast = Podcast.find(params[:id])
  end

  def new
    @podcast = Podcast.new
  end

  def edit
    @podcast = Podcast.find(params[:id])
  end

  def create
    @podcast = Podcast.new(params[:podcast])

    if @podcast.save
      flash[:notice] = 'Podcast was successfully created.'
      redirect_to(@podcast)
    else
      render :action => "new"
    end
  end

  def update
    @podcast = Podcast.find(params[:id])

    if @podcast.update_attributes(params[:podcast])
      flash[:notice] = 'Podcast was successfully updated.'
      redirect_to(@podcast)
    else
      render :action => "edit"
    end
  end

  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.destroy

    redirect_to(podcasts_url)
  end

end
