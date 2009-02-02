require File.dirname(__FILE__) + '/../../spec_helper'

describe "/widgets/new.html.haml" do
  include WidgetsHelper
  
  before(:each) do
    @widget = mock_model(Widget)
    @widget.errors.stub!(:empty?).and_return(true)
    @widget.stub!(:new_record?).and_return(true)
    @widget.stub!(:setup).and_return("MyString")
    @widget.stub!(:view).and_return("MyString")
    @widget.stub!(:column).and_return("1")
    @widget.stub!(:row).and_return("1")
    assigns[:widget] = @widget
  end

  it "should render new form" do
    render "/widgets/new.html.haml"
    
    response.should have_tag("form[action=?][method=post]", widgets_path) do
      with_tag("input#widget_setup[name=?]", "widget[setup]")
      with_tag("input#widget_view[name=?]", "widget[view]")
      with_tag("input#widget_column[name=?]", "widget[column]")
      with_tag("input#widget_row[name=?]", "widget[row]")
    end
  end
end


