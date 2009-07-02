require File.dirname(__FILE__) + '/../spec_helper'

describe JobsController do
  describe "route generation" do

    it "should map { :controller => 'jobs', :action => 'index' } to /jobs" do
      route_for(:controller => "jobs", :action => "index").should == "/jobs"
    end

    it "should map { :controller => 'jobs', :action => 'new' } to /jobs/new" do
      route_for(:controller => "jobs", :action => "new").should == "/jobs/new"
    end

    it "should map { :controller => 'jobs', :action => 'show', :id => 1 } to /jobs/1" do
      route_for(:controller => "jobs", :action => "show", :id => '1').should == "/jobs/1"
    end

    it "should map { :controller => 'jobs', :action => 'edit', :id => 1 } to /jobs/1/edit" do
      route_for(:controller => "jobs", :action => "edit", :id => '1').should == "/jobs/1/edit"
    end

    it "should map { :controller => 'jobs', :action => 'update', :id => 1} to /jobs/1" do
      route_for(:controller => "jobs", :action => "update", :id => '1').should == {:path => "/jobs/1", :method => :put}
    end

    it "should map { :controller => 'jobs', :action => 'destroy', :id => 1} to /jobs/1" do
      route_for(:controller => "jobs", :action => "destroy", :id => '1').should == {:path => "/jobs/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'jobs', action => 'index' } from GET /jobs" do
      params_from(:get, "/jobs").should == {:controller => "jobs", :action => "index"}
    end

    it "should generate params { :controller => 'jobs', action => 'new' } from GET /jobs/new" do
      params_from(:get, "/jobs/new").should == {:controller => "jobs", :action => "new"}
    end

    it "should generate params { :controller => 'jobs', action => 'create' } from POST /jobs" do
      params_from(:post, "/jobs").should == {:controller => "jobs", :action => "create"}
    end

    it "should generate params { :controller => 'jobs', action => 'show', id => '1' } from GET /jobs/1" do
      params_from(:get, "/jobs/1").should == {:controller => "jobs", :action => "show", :id => "1"}
    end

    it "should generate params { :controller => 'jobs', action => 'edit', id => '1' } from GET /jobs/1;edit" do
      params_from(:get, "/jobs/1/edit").should == {:controller => "jobs", :action => "edit", :id => "1"}
    end

    it "should generate params { :controller => 'jobs', action => 'update', id => '1' } from PUT /jobs/1" do
      params_from(:put, "/jobs/1").should == {:controller => "jobs", :action => "update", :id => "1"}
    end

    it "should generate params { :controller => 'jobs', action => 'destroy', id => '1' } from DELETE /jobs/1" do
      params_from(:delete, "/jobs/1").should == {:controller => "jobs", :action => "destroy", :id => "1"}
    end
  end
end