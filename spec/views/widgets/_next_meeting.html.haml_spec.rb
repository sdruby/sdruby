require File.dirname(__FILE__) + '/../../spec_helper'

describe "/widgets/_next_meeting.html.haml" do
  include WidgetsHelper
  
  before(:each) do
    @event = mock_model(Event, :starts_at => Time.now)
    assigns[:event] = @event
  end

  it "should render next meeting partial" do
    render "/widgets/_next_meeting.html.haml"
  end
end

