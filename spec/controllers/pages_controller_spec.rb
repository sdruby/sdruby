require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do
  integrate_views

  describe "on GET to about" do
    before { get :about }
    it { should respond_with(:success) }
  end

  describe "on GET to sponsors" do
    before { get :sponsors }
    it { should respond_with(:success) }
  end
end
