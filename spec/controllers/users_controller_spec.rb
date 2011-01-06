require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  integrate_views

  before do
    @user = Factory.create(:user)
  end

  describe "on GET to index" do
    before { get :index }
    it { should respond_with(:success) }
    it { should assign_to(:users) }
    it { should render_template(:index) }
  end

  describe "on GET to show" do
    before { get :show, :id => @user }
    it { should respond_with(:success) }
    it { should assign_to(:user) }
    it { should render_template(:show) }
  end

  context "when logged in" do
    before { login_as @user }

    describe "on GET to new" do
      before { get :new }
      it { should redirect_to(account_path) }
    end

    describe "on GET to edit" do
      before { get :edit, :id => @user }
      it { should respond_with(:success) }
      it { should assign_to(:user) }
    end

    describe "on PUT to update" do
      context "when valid" do
        before { put :update, :user => Factory.attributes_for(:user) }
        it { should redirect_to(user_path(@user)) }
        it { should set_the_flash }
      end

      context "when not valid" do
        before { put :update, :user => Factory.attributes_for(:user, :full_name => "") }
        it { should respond_with(:success) }
        it { should render_template(:edit) }
      end
    end
  end

  context "when not logged in" do
    describe "on GET to new" do
      before { get :new }
      it { should respond_with(:success) }
      it { should assign_to(:user) }
      it { should render_template(:new) }
    end

    describe "on POST to create" do
      context "when valid" do
        before do
          lambda { post :create, :user => Factory.attributes_for(:user) }.should change {
            User.count 
          }.by(1)
        end

        it { should redirect_to(user_path(assigns(:user))) }
        it { should set_the_flash }
      end

      context "when invalid" do
        before do
          lambda { post :create, :user => Factory.attributes_for(:user, :full_name => "") }.should_not change {
            User.count
          }
        end

        it { should respond_with(:success) }
        it { should render_template(:new) }
      end
    end
  end



end
