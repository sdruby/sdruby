require File.dirname(__FILE__) + '/../spec_helper'

describe UserSessionsController do
  render_views

  before { @user = FactoryGirl.create(:user) }

  context "when logged in" do
    before { login @user }

    describe "on GET to new" do
      before { get :new }
      it { should redirect_to(user_path(@user)) }
    end

    describe "on POST to create" do
      before { post :create }
      it { should redirect_to(user_path(@user)) }
    end

    describe "on DELETE to destroy" do
      before { delete :destroy }
      it { should redirect_to(root_path) }
      it { should set_the_flash }
    end
  end

  context "when not logged in" do
    describe "on GET to new" do
      before { get :new }
      it { should respond_with(:success) }
      it { should render_template(:new) }
    end

    describe "on POST to create" do
      context "when valid" do
        before { post :create, :user_session => {:email => @user.email, :password => "password"} }
        it { should respond_with(:redirect) }
      end

      context "when invalid" do
        before { post :create, :user_session => {:email => @user.email, :password => "wrong"} }
        it { should respond_with(:success) }
        it { should render_template(:new) }
      end
    end

    describe "on DELETE to destroy" do
      before { delete :destroy }
      it { should set_the_flash.to(/already logged out/) }
      it { should redirect_to(root_path) }
    end
  end

end

