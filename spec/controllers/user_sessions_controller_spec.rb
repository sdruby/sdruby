require File.dirname(__FILE__) + '/../spec_helper'

describe UserSessionsController do
  integrate_views

  before { @user = Factory.create(:user) }

  context "when logged in" do
    before { login_as @user }

    describe "on GET to new" do
      before { get :new }
      it { should redirect_to(account_path) }
    end

    describe "on POST to create" do
      before { post :create }
      it { should redirect_to(account_path) }
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

      end

      context "when invalid" do

      end
    end

    describe "on DELETE to destroy" do
      before { delete :destroy }

    end
  end

end

