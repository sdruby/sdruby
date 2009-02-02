require File.dirname(__FILE__) + '/../spec_helper'

describe Widget do
  fuzzy :widgets
  before(:each) do
    @widget = fuzzy_widgets.create!
  end

  it "should be valid" do
    @widget.should be_valid
  end

  it "should have a default setup method" do
    @widget.setup.should == 'default'
  end
  
end
