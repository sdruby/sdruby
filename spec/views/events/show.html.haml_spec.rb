require File.dirname(__FILE__) + '/../../spec_helper'

describe "/events/show.html.haml" do
  include EventsHelper
  
  before(:each) do
    @event = mock_model(Event)
    @event.stub!(:is_private).and_return(false)
    @event.stub!(:starts_at).and_return(Time.now)
    @event.stub!(:ends_at).and_return(Time.now)
    @event.stub!(:name).and_return("MyString")
    @event.stub!(:description).and_return("MyText")

    assigns[:event] = @event
  end

  it "should render attributes in <p>" do
    render "/events/show.html.haml"
    response.should have_text(/als/)
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

