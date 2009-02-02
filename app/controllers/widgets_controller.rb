class WidgetsController < ApplicationController
  include WidgetsHelper

  def index
    @widgets = Widget.find(:all, :order => "row")
    @widgets.each do |widget|
      send(widget.setup)
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @widgets }
    end
  end

  def show
    @widget = Widget.find(params[:id])
    send(@widget.setup)

    respond_to do |format|
      format.html { render :partial => @widget.view }
      format.xml  { render :xml => @widget }
    end
  end

  def new
    @widget = Widget.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @widget }
    end
  end

  def edit
    @widget = Widget.find(params[:id])
  end

  def create
    @widget = Widget.new(params[:widget])

    respond_to do |format|
      if @widget.save
        flash[:notice] = 'Widget was successfully created.'
        format.html { redirect_to(@widget) }
        format.xml  { render :xml => @widget, :status => :created, :location => @widget }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @widget.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @widget = Widget.find(params[:id])

    respond_to do |format|
      if @widget.update_attributes(params[:widget])
        flash[:notice] = 'Widget was successfully updated.'
        format.html { redirect_to(@widget) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @widget.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @widget = Widget.find(params[:id])
    @widget.destroy

    respond_to do |format|
      format.html { redirect_to(widgets_url) }
      format.xml  { head :ok }
    end
  end
end
