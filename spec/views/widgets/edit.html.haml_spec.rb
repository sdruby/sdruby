require File.dirname(__FILE__) + '/../../spec_helper'

describe "/widgets/edit.html.haml" do
  include WidgetsHelper
  
  before do
    @widget = mock_model(Widget)
    @widget.errors.stub!(:empty?).and_return(true)
    
    @widget.stub!(:setup).and_return("MyString")
    @widget.stub!(:view).and_return("MyString")
    @widget.stub!(:column).and_return("1")
    @widget.stub!(:row).and_return("1")
    assigns[:widget] = @widget
  end

  it "should render edit form" do
    render "/widgets/edit.html.haml"
    
    response.should have_tag("form[action=#{widget_path(@widget)}][method=post]") do
      with_tag('input#widget_setup[name=?]', "widget[setup]")
      with_tag('input#widget_view[name=?]', "widget[view]")
      with_tag('input#widget_column[name=?]', "widget[column]")
      with_tag('input#widget_row[name=?]', "widget[row]")
    end
  end
end


