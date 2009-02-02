require File.dirname(__FILE__) + '/../../spec_helper'

describe "/events/index.html.haml" do
  include EventsHelper
  
  before(:each) do
    event_98 = mock_model(Event)
    event_98.should_receive(:is_private).and_return(false)
    event_98.should_receive(:starts_at).and_return(Time.now)
    event_98.should_receive(:ends_at).and_return(Time.now)
    event_98.should_receive(:name).and_return("MyString")
    event_98.should_receive(:description).and_return("MyText")
    event_99 = mock_model(Event)
    event_99.should_receive(:is_private).and_return(false)
    event_99.should_receive(:starts_at).and_return(Time.now)
    event_99.should_receive(:ends_at).and_return(Time.now)
    event_99.should_receive(:name).and_return("MyString")
    event_99.should_receive(:description).and_return("MyText")

    assigns[:events] = [event_98, event_99]
  end

  it "should render list of events" do
    render "/events/index.html.haml"
  end
end

