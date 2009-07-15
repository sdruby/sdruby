require File.dirname(__FILE__) + '/../spec_helper'

describe EventsController do
  fuzzy :events, :meetings
  describe "handling GET /events" do

    before(:each) do
      @event = fuzzy_events.create!
      Event.stub!(:find).and_return([@event])
    end
  
    def do_get
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end
  
    it "should find all events" do
      Event.should_receive(:find).with(:all).and_return([@event])
      do_get
    end
  
    it "should assign the found events for the view" do
      do_get
      assigns[:events].should == [@event]
    end
  end

  describe "handling GET /events/1" do

    before(:each) do
      @event = fuzzy_events.create!
      Event.stub!(:find).and_return(@event)
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render show template" do
      do_get
      response.should render_template('show')
    end
  
    it "should find the event requested" do
      Event.should_receive(:find).with("1").and_return(@event)
      do_get
    end
  
    it "should assign the found event for the view" do
      do_get
      assigns[:event].should equal(@event)
    end
  end

  describe "handling GET /events/new" do

    before(:each) do
      @event = fuzzy_events.create!
      Event.stub!(:new).and_return(@event)
    end
  
    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render new template" do
      do_get
      response.should render_template('new')
    end
  
    it "should create an new event" do
      Event.should_receive(:new).and_return(@event)
      do_get
    end
  
    it "should not save the new event" do
      @event.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new event for the view" do
      do_get
      assigns[:event].should equal(@event)
    end
  end

  describe "handling GET /events/1/edit" do

    before(:each) do
      @event = fuzzy_events.create!
      Event.stub!(:find).and_return(@event)
    end
  
    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end
  
    it "should find the event requested" do
      Event.should_receive(:find).and_return(@event)
      do_get
    end
  
    it "should assign the found Event for the view" do
      do_get
      assigns[:event].should equal(@event)
    end
  end

  describe "handling POST /events" do

    before(:each) do
      @event = Event.create!
      @meeting = fuzzy_meetings.create!
    end
    
    describe "with successful save" do
  
      def do_post
        post :create, :event => {'class' => 'Event'}
      end
  
      it "should create a new event" do

        do_post
        assigns(:event).class.should == Event
      end

      it "should redirect to the new event" do
        do_post
        last_event = Event.last
        response.should redirect_to(event_url(last_event.id))
      end
      
    end

    describe "with successful save with Meeting type" do
  
      def do_post
        post :create, :event => {'class' => 'Meeting'}
      end
  
      it "should create a new event" do

        do_post
        assigns(:event).class.should == Meeting
      end

      it "should redirect to the new event" do
        do_post
        last_meeting = Meeting.last
        response.should redirect_to(meeting_url(last_meeting.id))
      end
      
    end

    
    describe "with failed save" do

      def do_post
        Event.should_receive(:new).and_return(@event)
        @event.should_receive(:save).and_return(false)
        post :create, :event => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /events/1" do

    before(:each) do
      @event = fuzzy_events.create!
      Event.stub!(:find).and_return(@event)
    end
    
    describe "with successful update" do

      def do_put
        @event.should_receive(:update_attributes).and_return(true)
        put :update, :id => @event.id
      end

      it "should find the event requested" do
        Event.should_receive(:find).with(@event.id.to_s).and_return(@event)
        do_put
      end

      it "should update the found event" do
        do_put
        assigns(:event).should equal(@event)
      end

      it "should assign the found event for the view" do
        do_put
        assigns(:event).should equal(@event)
      end

      it "should redirect to the event" do
        do_put
        response.should redirect_to(event_url(@event.id))
      end

    end
    
    describe "with failed update" do

      def do_put
        @event.should_receive(:update_attributes).and_return(false)
        put :update, :id => @event.id
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /events/1" do

    before(:each) do
      @event = fuzzy_events.create!
      Event.stub!(:find).and_return(@event)
    end
  
    def do_delete
      delete :destroy, :id => @event.id
    end

    it "should find the event requested" do
      Event.should_receive(:find).with(@event.id.to_s).and_return(@event)
      do_delete
    end
  
    it "should call destroy on the found event" do
      @event.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the events list" do
      do_delete
      response.should redirect_to(events_url)
    end
  end
end
