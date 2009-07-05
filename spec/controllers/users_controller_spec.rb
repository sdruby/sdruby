require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fuzzy :users

  describe "GET show" do
    describe "requesting HTML" do
      context 'for a valid user' do
        before do
          @user = fuzzy_users.create!(:password => "testing", :password_confirmation => "testing")
          set_session_for(@user)

          User.stub!(:find).and_return(@user)

          get :show, :id => @user.id
        end

        it "should be successful" do
          response.should be_success
        end

        it "should render show template" do
          response.should render_template('show')
        end

        it "should assign the found user for the view" do
          assigns[:user].should equal(@user)
        end
      end

      context 'for an invalid user' do
        before do
          login_as users(:loyal_rubyist)

          get :show, :id => 'snoop doggy dogg'
        end

        it 'should flash a notice' do
          flash[:notice].should == 'No such user.'
        end

        it 'should redirect to /' do
          response.should redirect_to(root_path)
        end
      end
    end
  end

  describe "GET new" do
    context 'logged in' do
      before do
        set_session_for users(:loyal_rubyist)
        get :new
      end

      it 'should redirect to /account' do
        response.should redirect_to(account_path)
      end
    end

    context 'not logged in' do
      before do
        @user = fuzzy_users.create!(:password => "testing", :password_confirmation => "testing")

        User.should_receive(:new).and_return(@user)

        get :new
      end

      it "should be successful" do
        response.should be_success
      end

      it "should render new template" do
        response.should render_template('new')
      end

      it "should create an new user and assign it for the view" do
        assigns[:user].should == @user                 
      end
    end
  end

  describe "GET edit" do
    context 'logged in' do
      before do
        @user = fuzzy_users.create!(:password => "testing", :password_confirmation => "testing")
        set_session_for(@user)

        User.should_receive(:find).and_return(@user)

        get :edit, :id => @user.id
      end

      it "should be successful" do
        response.should be_success
      end

      it "should render edit template" do
        response.should render_template('edit')
      end

      it "should assign the found User for the view" do
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

  describe "POST create" do
    before do
      @user = fuzzy_users.create!(:password => "testing", :password_confirmation => "testing")
      set_session_for(@user)

      User.should_receive(:new).with({}).and_return(@user)
    end

    describe "with successful save" do
      before do
        @user.should_receive(:save).and_return(true)
        post :create, :user => {}
      end

      it "should redirect to the new user" do
        response.should redirect_to(user_url(@user.id))
      end
    end

    describe "with failed save" do
      before do
        @user.should_receive(:save).and_return(false)
        post :create, :user => {}
      end

      it "should re-render 'new'" do
        response.should render_template('new')
      end
    end
  end

  describe "PUT update" do
    context 'logged in' do
      before(:each) do
        @user = fuzzy_users.create!(:password => "testing", :password_confirmation => "testing")
        set_session_for(@user)

        User.stub!(:find).and_return(@user)
      end

      describe "with successful update" do
        before do
          @user.should_receive(:update_attributes).and_return(true)

          put :update, :id => @user.id
        end

        it "should update the found user" do
          assigns(:user).should equal(@user)
        end

        it "should assign the found user for the view" do
          assigns(:user).should equal(@user)
        end

        it "should redirect to the user" do
          response.should redirect_to(user_url(@user.id))
        end
      end

      describe "with failed update" do
        before do
          @user.should_receive(:update_attributes).and_return(false)

          put :update, :id => @user.id
        end

        it "should re-render 'edit'" do
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