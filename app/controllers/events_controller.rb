class EventsController < ApplicationController
  before_filter :find_event, :except => [:index, :new, :create]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    event_klass = params[:event].delete(:class) || "Event"
    @event = event_klass.constantize.new(params[:event])

    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to(@event)
    else
      render :action => "new"
    end
  end

  def update
    if @event.update_attributes(params[:event] || params[:meeting])
      flash[:notice] = 'Event was successfully updated.'
      redirect_to(@event)
    else
      render :action => "edit"
    end
  end

  protected

  def find_event
    @event = Event.find(params[:id])
  end
end
