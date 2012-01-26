require File.dirname(__FILE__) + '/../spec_helper'

describe HomeController do
  render_views

  before do
    @podcast = Factory.create(:podcast)
  end

  describe "on GET to index" do
    before { get :index }
    it { should respond_with(:success) }
    it { should render_template(:index) }
    it { should assign_to(:podcast) }
  end
end
