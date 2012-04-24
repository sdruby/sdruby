require File.dirname(__FILE__) + '/../spec_helper'

describe ProjectsController do
  render_views

  before do
    3.times do
      FactoryGirl.create(:project)
    end
  end

  describe "on GET to index" do
    before { get :index }
    it { should respond_with(:success) }
    it { should assign_to(:projects) }
  end
end
