require File.dirname(__FILE__) + '/../spec_helper'

describe WidgetsController do
  describe "route generation" do

    it "should map { :controller => 'widgets', :action => 'index' } to /widgets" do
      route_for(:controller => "widgets", :action => "index").should == "/widgets"
    end
  
    it "should map { :controller => 'widgets', :action => 'new' } to /widgets/new" do
      route_for(:controller => "widgets", :action => "new").should == "/widgets/new"
    end
  
    it "should map { :controller => 'widgets', :action => 'show', :id => 1 } to /widgets/1" do
      route_for(:controller => "widgets", :action => "show", :id => '1').should == "/widgets/1"
    end
  
    it "should map { :controller => 'widgets', :action => 'edit', :id => 1 } to /widgets/1/edit" do
      route_for(:controller => "widgets", :action => "edit", :id => '1').should == "/widgets/1/edit"
    end
  
    it "should map { :controller => 'widgets', :action => 'update', :id => 1} to /widgets/1" do
      route_for(:controller => "widgets", :action => "update", :id => '1').should == {:path => "/widgets/1", :method => :put}
    end
  
    it "should map { :controller => 'widgets', :action => 'destroy', :id => 1} to /widgets/1" do
      route_for(:controller => "widgets", :action => "destroy", :id => '1').should == {:path => "/widgets/1", :method => :delete}
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'widgets', action => 'index' } from GET /widgets" do
      params_from(:get, "/widgets").should == {:controller => "widgets", :action => "index"}
    end
  
    it "should generate params { :controller => 'widgets', action => 'new' } from GET /widgets/new" do
      params_from(:get, "/widgets/new").should == {:controller => "widgets", :action => "new"}
    end
  
    it "should generate params { :controller => 'widgets', action => 'create' } from POST /widgets" do
      params_from(:post, "/widgets").should == {:controller => "widgets", :action => "create"}
    end
  
    it "should generate params { :controller => 'widgets', action => 'show', id => '1' } from GET /widgets/1" do
      params_from(:get, "/widgets/1").should == {:controller => "widgets", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'widgets', action => 'edit', id => '1' } from GET /widgets/1;edit" do
      params_from(:get, "/widgets/1/edit").should == {:controller => "widgets", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'widgets', action => 'update', id => '1' } from PUT /widgets/1" do
      params_from(:put, "/widgets/1").should == {:controller => "widgets", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'widgets', action => 'destroy', id => '1' } from DELETE /widgets/1" do
      params_from(:delete, "/widgets/1").should == {:controller => "widgets", :action => "destroy", :id => "1"}
    end
  end
end