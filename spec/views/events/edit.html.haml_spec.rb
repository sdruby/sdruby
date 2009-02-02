require File.dirname(__FILE__) + '/../../spec_helper'

describe "/events/edit.html.haml" do
  include EventsHelper
  
  before do
    @event = mock_model(Event)
    @event.errors.stub!(:empty?).and_return(true)
    @event.stub!(:is_private).and_return(false)
    @event.stub!(:starts_at).and_return(Time.now)
    @event.stub!(:ends_at).and_return(Time.now)
    @event.stub!(:name).and_return("MyString")
    @event.stub!(:description).and_return("MyText")
    assigns[:event] = @event
  end

  it "should render edit form" do
    render "/events/edit.html.haml"
    
    response.should have_tag("form[action=#{event_path(@event)}][method=post]") do
      with_tag('input#event_is_private[name=?]', "event[is_private]")
      with_tag('input#event_name[name=?]', "event[name]")
      with_tag('textarea#event_description[name=?]', "event[description]")
    end
  end
end


