require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fuzzy :users

  describe "handling GET /users/1" do
    context 'logged in' do
    before(:each) do
      @user = fuzzy_users.create!(:password => "testing", :password_confirmation => "testing")
      set_session_for(@user)
      User.stub!(:find).and_return(@user)
    end

    def do_get
      get :show, :id => @user.id
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render show template" do
      do_get
      response.should render_template('show')
    end

    it "should assign the found user for the view" do
      do_get
      assigns[:user].should equal(@user)
    end
  end

    context 'not logged in' do
      before do
        logout
        get :show
      end

      it 'should redirect to login path' do
        response.should redirect_to(login_path)
      end
    end
  end

  describe "handling GET /users/1.xml" do
    before(:each) do
      @user = fuzzy_users.create!(:password => "testing", :password_confirmation => "testing")
      set_session_for(@user)
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

    it "should render the found user as xml" do
      @user.should_receive(:to_xml).and_return("XML")
      do_get
      response.body.should == "XML"
    end
  end

  describe "handling GET /users/new" do
    context 'logged in' do
      before do
        set_session_for users(:loyal_rubyist)
        get :new
      end

      it 'should redirect to accounts' do
        response.should redirect_to(account_path)
      end
    end

    context 'not logged in' do
      before(:each) do
        @user = fuzzy_users.create!(:password => "testing", :password_confirmation => "testing")
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
  end

  describe "handling GET /users/1/edit" do
    context 'logged in' do
      before(:each) do
        @user = fuzzy_users.create!(:password => "testing", :password_confirmation => "testing")
        set_session_for(@user)
        User.stub!(:find).and_return(@user)
      end

      def do_get
        get :edit, :id => @user.id
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

    context 'logged in as a different user' do
      before do
        set_session_for users(:loyal_rubyist)
        get :edit, :id => users(:job_creating_rubyist).id
      end

      it 'should redirect to /' do
        response.should redirect_to(root_path)        
      end

      it 'should set an error message' do
        flash[:error].should == "You are not authorized to edit this resource"
      end
    end

    context 'not logged in' do
      before do
        logout
        get :edit
      end

      it 'should redirect to login path' do
        response.should redirect_to(login_path)
      end
    end


  end

  describe "handling POST /users" do

    before(:each) do
      @user = fuzzy_users.create!(:password => "testing", :password_confirmation => "testing")
      set_session_for(@user)
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
        response.should redirect_to(user_url(@user.id))
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
    context 'logged in' do
      before(:each) do
        @user = fuzzy_users.create!(:password => "testing", :password_confirmation => "testing")
        set_session_for(@user)
        User.stub!(:find).and_return(@user)
      end

      describe "with successful update" do
        def do_put
          @user.should_receive(:update_attributes).and_return(true)
          put :update, :id => @user.id
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
          response.should redirect_to(user_url(@user.id))
        end
      end

      describe "with failed update" do
        def do_put
          @user.should_receive(:update_attributes).and_return(false)
          put :update, :id => @user.id
        end

        it "should re-render 'edit'" do
          do_put
          response.should render_template('edit')
        end
      end
    end

    context 'logged in as a different user' do
      before do
        set_session_for users(:loyal_rubyist)
        put :update, :id => users(:job_creating_rubyist).id
      end

      it 'should redirect to /' do
        response.should redirect_to(root_path)
      end

      it 'should set an error message' do
        flash[:error].should == "You are not authorized to edit this resource"
      end
    end

    context 'not logged in' do
      before do
        logout
        put :update
      end

      it 'should redirect to /login' do
        response.should redirect_to(login_path)
      end
    end
  end
end
