require File.dirname(__FILE__) + '/../spec_helper'

describe EventsController do
  integrate_views

  before do
    @event = Factory.create(:event)
    @meeting = Factory.create(:meeting)
  end

  describe "on GET to index" do
    before { get :index }
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should assign_to(:events) }
  end

  describe "on GET to show" do
    before { get :show, :id => @event }
    it { should respond_with(:success) }
    it { should render_template(:show) }
    it { should assign_to(:event) }
  end

  describe "on GET to new" do
    before { get :new }
    it { should respond_with(:success) }
    it { should render_template(:new) }
    it { should assign_to(:event) }
  end

  describe "on POST to create" do
    context "when valid" do
      before do
        lambda { post :create, :event => Factory.attributes_for(:event) }
      end

      it { should redirect_to(event_path(@event)) }
    end

    context "when invalid" do
      before do
        lambda { post :create, :event => Factory.attributes_for(:event, :title => "") }
      end

      it { should respond_with(:success) }
      it { should render_template(:new) }
    end
  end

  describe "on GET to edit" do
    before { get :edit, :id => @event }
    it { should respond_with(:success) }
    it { should render_template(:edit) }
    it { should assign_to(:event) }
  end

  describe "on PUT to update" do
    context "when valid" do
      before do
        lambda { put :update, :id => @event, :event => Factory.attributes_for(:event) }
      end

      it { should redirect_to(event_path(@event)) }
    end

    context "when invalid" do
      before do
        lambda { put :update, :id => @event, :event => Factory.attributes_for(:event) }
      end

      it { should respond_with(:success) }
      it { should render_template(:edit) }
    end
  end

  describe "on DELETE to destroy" do
    before do
      lambda { delete :destroy, :id => @event }.should change { Event.count }.by(-1)
    end

    it { should respond_with(:redirect) }
  end

end
