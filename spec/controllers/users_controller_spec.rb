require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  render_views

  before do
    @user = FactoryGirl.create(:user)
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
    before { login @user }

    describe "on GET to new" do
      before { get :new }
      it { should redirect_to(user_path(@user)) }
    end

    describe "on GET to edit" do
      before { get :edit, :id => @user }
      it { should respond_with(:success) }
      it { should assign_to(:user) }
    end

    describe "on PUT to update" do
      context "when valid" do
        before { put :update, :id => @user.id, :user => FactoryGirl.attributes_for(:user) }
        it { should redirect_to(user_path(@user)) }
        it { should set_the_flash }
      end

      context "when not valid" do
        before { put :update, :id => @user.id, :user => FactoryGirl.attributes_for(:user, :full_name => "") }
        it { should respond_with(:success) }
        it { should render_template(:edit) }
      end
    end

    describe "on DELETE to destroy" do
      before do
        lambda { delete :destroy, :id => @user }.should change { User.count }.by(-1)
      end

      it { should respond_with(:redirect) }
      it { should set_the_flash.to(/deleted/) }
    end


    context "as admin" do
      before { login FactoryGirl.create(:admin) }

      describe "on GET to edit" do
        before { get :edit, :id => @user }
        it { should respond_with(:success) }
        it { should assign_to(:user) }
      end

      describe "on PUT to update" do
        context "when valid" do
          before { put :update, :id => @user.id, :user => FactoryGirl.attributes_for(:user) }
          it { should redirect_to(user_path(@user)) }
          it { should set_the_flash }
        end

        context "when not valid" do
          before { put :update, :id => @user.id, :user => FactoryGirl.attributes_for(:user, :full_name => "") }
          it { should respond_with(:success) }
          it { should render_template(:edit) }
        end
      end

      describe "on DELETE to destroy" do
        before do
          lambda { delete :destroy, :id => @user }.should change { User.count }.by(-1)
        end

        it { should respond_with(:redirect) }
        it { should set_the_flash.to(/deleted/) }
      end
    end

    context "with another user" do
      before { @another_user = FactoryGirl.create(:user) }

      describe "on GET to edit" do
        before { get :edit, :id => @another_user }
        it { should respond_with(:redirect) }
        it { should set_the_flash.to(/not authorized/) }
      end

      describe "on PUT to update" do
        before { put :update, :id => @another_user, :user => FactoryGirl.attributes_for(:user) }
        it { should respond_with(:redirect) }
        it { should set_the_flash.to(/not authorized/) }
      end

      describe "on DELETE to destroy" do
        before { delete :destroy, :id => @another_user }
        it { should respond_with(:redirect) }
        it { should set_the_flash.to(/not authorized/) }
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
      before do
        controller.stub!(:recaptcha_valid?).and_return(true)
      end

      context "when valid" do
        before do
          lambda { post :create, :user => FactoryGirl.attributes_for(:user) }.should change {
            User.count 
          }.by(1)
        end

        it { should redirect_to(user_path(assigns(:user))) }
        it { should set_the_flash }
      end

      context "when invalid" do
        before do
          lambda { post :create, :user => FactoryGirl.attributes_for(:user, :full_name => "") }.should_not change {
            User.count
          }
        end

        it { should respond_with(:success) }
        it { should render_template(:new) }
      end
    end
  end

end
