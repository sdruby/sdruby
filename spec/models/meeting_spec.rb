require File.dirname(__FILE__) + '/../spec_helper'

describe Meeting do
  fuzzy :events

  before(:each) do
    @meeting = Meeting.new
  end

  it "should be valid" do
    @meeting.should be_valid
  end
  
  describe "Meeting.next" do
    
    it "should return the next meeting in time" do
      old_meeting = Meeting.create!(fuzzy_events.generate_columns(:starts_at => 1.minute.ago, :ends_at => 1.minute.from_now, :is_private => false))
      next_meeting = Meeting.create!(fuzzy_events.generate_columns(:starts_at => 10.minute.from_now, :ends_at => 10.minute.from_now, :is_private => false))
      inactive_meeting = Meeting.create!(fuzzy_events.generate_columns(:starts_at => 5.minute.from_now, :ends_at => 10.minute.from_now, :is_private => true))
      next_event = fuzzy_events.create!(:starts_at => 5.minute.from_now, :ends_at => 10.minute.from_now, :is_private => false)
      Meeting.next.should == next_meeting
    end
  end
end
