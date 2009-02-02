require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  describe "handling GET /users" do

    before(:each) do
      @user = mock_model(User)
      User.stub!(:find).and_return([@user])
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
  
    it "should find all users" do
      User.should_receive(:find).with(:all).and_return([@user])
      do_get
    end
  
    it "should assign the found users for the view" do
      do_get
      assigns[:users].should == [@user]
    end
  end

  describe "handling GET /users.xml" do

    before(:each) do
      @user = mock_model(User, :to_xml => "XML")
      User.stub!(:find).and_return(@user)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :index
    end
  
    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should find all users" do
      User.should_receive(:find).with(:all).and_return([@user])
      do_get
    end
  
    it "should render the found users as xml" do
      @user.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /users/1" do

    before(:each) do
      @user = mock_model(User)
      User.stub!(:find).and_return(@user)
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
  
    it "should find the user requested" do
      User.should_receive(:find).with("1").and_return(@user)
      do_get
    end
  
    it "should assign the found user for the view" do
      do_get
      assigns[:user].should equal(@user)
    end
  end

  describe "handling GET /users/1.xml" do

    before(:each) do
      @user = mock_model(User, :to_xml => "XML")
      User.stub!(:find).and_return(@user)
    end
  
    def do_get
      @request.env["HTTP_ACCEPT"] = "application/xml"
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end
  
    it "should find the user requested" do
      User.should_receive(:find).with("1").and_return(@user)
      do_get
    end
  
    it "should render the found user as xml" do
      @user.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /users/new" do

    before(:each) do
      @user = mock_model(User)
      User.stub!(:new).and_return(@user)
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
  
    it "should create an new user" do
      User.should_receive(:new).and_return(@user)
      do_get
    end
  
    it "should not save the new user" do
      @user.should_not_receive(:save)
      do_get
    end
  
    it "should assign the new user for the view" do
      do_get
      assigns[:user].should equal(@user)
    end
  end

  describe "handling GET /users/1/edit" do

    before(:each) do
      @user = mock_model(User)
      User.stub!(:find).and_return(@user)
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
  
    it "should find the user requested" do
      User.should_receive(:find).and_return(@user)
      do_get
    end
  
    it "should assign the found User for the view" do
      do_get
      assigns[:user].should equal(@user)
    end
  end

  describe "handling POST /users" do

    before(:each) do
      @user = mock_model(User, :to_param => "1")
      User.stub!(:new).and_return(@user)
    end
    
    describe "with successful save" do
  
      def do_post
        @user.should_receive(:save).and_return(true)
        post :create, :user => {}
      end
  
      it "should create a new user" do
        User.should_receive(:new).with({}).and_return(@user)
        do_post
      end

      it "should redirect to the new user" do
        do_post
        response.should redirect_to(user_url("1"))
      end
      
    end
    
    describe "with failed save" do

      def do_post
        @user.should_receive(:save).and_return(false)
        post :create, :user => {}
      end
  
      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end
      
    end
  end

  describe "handling PUT /users/1" do

    before(:each) do
      @user = mock_model(User, :to_param => "1")
      User.stub!(:find).and_return(@user)
    end
    
    describe "with successful update" do

      def do_put
        @user.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the user requested" do
        User.should_receive(:find).with("1").and_return(@user)
        do_put
      end

      it "should update the found user" do
        do_put
        assigns(:user).should equal(@user)
      end

      it "should assign the found user for the view" do
        do_put
        assigns(:user).should equal(@user)
      end

      it "should redirect to the user" do
        do_put
        response.should redirect_to(user_url("1"))
      end

    end
    
    describe "with failed update" do

      def do_put
        @user.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end
  end

  describe "handling DELETE /users/1" do

    before(:each) do
      @user = mock_model(User, :destroy => true)
      User.stub!(:find).and_return(@user)
    end
  
    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the user requested" do
      User.should_receive(:find).with("1").and_return(@user)
      do_delete
    end
  
    it "should call destroy on the found user" do
      @user.should_receive(:destroy)
      do_delete
    end
  
    it "should redirect to the users list" do
      do_delete
      response.should redirect_to(users_url)
    end
  end
end