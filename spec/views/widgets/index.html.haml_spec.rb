require File.dirname(__FILE__) + '/../../spec_helper'

describe "/widgets/index.html.haml" do
  include WidgetsHelper
  
  before(:each) do
    widget_98 = mock_model(Widget)
    widget_98.stub!(:setup).and_return("default")
    widget_98.stub!(:view).and_return("google_groups")
    widget_98.stub!(:column).and_return("1")
    widget_98.stub!(:row).and_return("1")
    widget_99 = mock_model(Widget)
    widget_99.stub!(:setup).and_return("default")
    widget_99.stub!(:view).and_return("google_groups")
    widget_99.stub!(:column).and_return("1")
    widget_99.stub!(:row).and_return("1")

    assigns[:widgets] = [widget_98, widget_99]
  end

  it "should render list of widgets" do
    render "/widgets/index.html.haml"
  end
end

