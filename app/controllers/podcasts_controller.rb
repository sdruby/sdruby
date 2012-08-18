class PodcastsController < ApplicationController
  before_filter :require_admin, :except => [:index, :show, :search]
  before_filter :find_podcast, :except => [:index, :new, :create, :search]

  def index
    @podcasts = Podcast.published.all

    respond_to do |format|
      format.html do
        @podcast = @podcasts.shift
        @years = @podcasts.collect { |episode| episode.created_at.strftime('%Y') }.uniq
      end

      format.atom { render :layout => false }
      format.rss { render :layout => false }
    end
  end

  def show
  end

  def new
    @podcast = Podcast.new
  end

  def edit
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
    if @podcast.update_attributes(params[:podcast])
      flash[:notice] = 'Podcast was successfully updated.'
      redirect_to(@podcast)
    else
      render :action => "edit"
    end
  end

  def destroy
    @podcast.destroy
    flash[:notice] = 'Podcast was successfully destroyed.'
    redirect_to podcasts_path
  end

  def search
    @episodes = Podcast.search do
      fulltext params[:q]
      order_by :id, :desc
    end

    respond_to do |format|
      format.html
      format.json { render :json => @episodes.results, :only => [:id] }
    end
  end

  protected

  def find_podcast
    @podcast = Podcast.find(params[:id])
  end
end
