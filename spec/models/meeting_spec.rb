require File.dirname(__FILE__) + '/../spec_helper'

describe "Meeting" do
  before { @meeting = Factory(:meeting) }

  it "should be valid" do
    @meeting.should be_valid
  end
end
