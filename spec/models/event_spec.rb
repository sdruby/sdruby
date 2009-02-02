require File.dirname(__FILE__) + '/../spec_helper'

describe Event do
  fuzzy :events
  before(:each) do
    @event = Event.new
  end

  it "should be valid" do
    @event.should be_valid
  end
  
  describe "Event.next" do
    
    it "should return the next event in time" do
      old_event = fuzzy_events.create!(:starts_at => 1.minute.ago, :ends_at => 1.minute.from_now, :is_private => false)
      next_event = fuzzy_events.create!(:starts_at => 10.minute.from_now, :ends_at => 10.minute.from_now, :is_private => false)
      inactive_event = fuzzy_events.create!(:starts_at => 5.minute.from_now, :ends_at => 10.minute.from_now, :is_private => true)
            
      Event.next.should == next_event
    end
  end
end
