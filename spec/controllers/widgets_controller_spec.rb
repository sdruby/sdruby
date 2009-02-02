require File.dirname(__FILE__) + '/../spec_helper'

describe WidgetsController do
  describe "handling GET /widgets" do

    before(:each) do
      @widget = mock_model(Widget, :setup => "default", :view => "google_groups")
      Widget.stub!(:find).and_return([@widget])
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
  
    it "should find all widgets" do
      Widget.should_receive(:find).with(:all, :order => "row").and_return([@widget])
      do_get
    end
  
    it "should assign the found widgets for the view" do
      do_get
      assigns[:widgets].should == [@widget]
    end
  end

  describe "handling GET /widgets.xml" do

    before(:each) do
      @widget = mock_model(Widget, :setup => "default", :view => "google_groups", :to_xml => "XML")
      Widget.stub!(:find).and_return([@widget])
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all widgets" do
      Widget.should_receive(:find).with(:all, :order => "row").and_return([@widget])
      do_get
    end
  end

  describe "handling GET /widgets/1" do

    before(:each) do
      @widget = mock_model(Widget)
      Widget.stub!(:find).and_return(@widget)
      @widget.stub!(:view).and_return('map')
      @widget.stub!(:setup).and_return('default')
      
    end
  
    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should render widgets view partial" do
      do_get
      response.should render_template('_map')
    end
    
    it "should call widgets setup method" do
      @widget.should_receive(:setup).and_return("default")
      do_get
    end
  
    it "should find the widget requested" do
      Widget.should_receive(:find).with("1").and_return(@widget)
      do_get
    end
  
    it "should assign the found widget for the view" do
      do_get
      assigns[:widget].should equal(@widget)
    end
  end

  describe "handling GET /widgets/1.xml" do

    before(:each) do
      @widget = mock_model(Widget, :to_xml => "XML")
      Widget.stub!(:find).and_return(@widget)
      @widget.stub!(:setup).and_return('default')
      
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the widget requested" do
      Widget.should_receive(:find).with("1").and_return(@widget)
      do_get
    end
  
    it "should render the found widget as xml" do
      @widget.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /widgets/new" do

    before(:each) do
      @widget = mock_model(Widget)
      Widget.stub!(:new).and_return(@widget)
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
  
    it "should create an new widget" do
      Widget.should_receive(:new).and_return(@widget)
      do_get
    end
  
    it "should not save the new widget" do
      @widget.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new widget for the view" do
      do_get
      assigns[:widget].should equal(@widget)
    end
  end

  describe "handling GET /widgets/1/edit" do

    before(:each) do
      @widget = mock_model(Widget)
      Widget.stub!(:find).and_return(@widget)
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
  
    it "should find the widget requested" do
      Widget.should_receive(:find).and_return(@widget)
      do_get
    end
  
    it "should assign the found Widget for the view" do
      do_get
      assigns[:widget].should equal(@widget)
    end
  end

  describe "handling POST /widgets" do

    before(:each) do
      @widget = mock_model(Widget, :to_param => "1")
      Widget.stub!(:new).and_return(@widget)
    end
    
    describe "with successful save" do
  
      def do_post
        @widget.should_receive(:save).and_return(true)
        post :create, :widget => {}
      end
  
      it "should create a new widget" do
        Widget.should_receive(:new).with({}).and_return(@widget)
        do_post
      end

      it "should redirect to the new widget" do
        do_post
        response.should redirect_to(widget_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @widget.should_receive(:save).and_return(false)
        post :create, :widget => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /widgets/1" do

    before(:each) do
      @widget = mock_model(Widget, :to_param => "1")
      Widget.stub!(:find).and_return(@widget)
    end
    
    describe "with successful update" do

      def do_put
        @widget.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the widget requested" do
        Widget.should_receive(:find).with("1").and_return(@widget)
        do_put
      end

      it "should update the found widget" do
        do_put
        assigns(:widget).should equal(@widget)
      end

      it "should assign the found widget for the view" do
        do_put
        assigns(:widget).should equal(@widget)
      end

      it "should redirect to the widget" do
        do_put
        response.should redirect_to(widget_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @widget.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /widgets/1" do

    before(:each) do
      @widget = mock_model(Widget, :destroy => true)
      Widget.stub!(:find).and_return(@widget)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the widget requested" do
      Widget.should_receive(:find).with("1").and_return(@widget)
      do_delete
    end
  
    it "should call destroy on the found widget" do
      @widget.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the widgets list" do
      do_delete
      response.should redirect_to(widgets_url)
    end
  end
end