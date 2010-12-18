require File.dirname(__FILE__) + '/../spec_helper'

describe Widget do
  before { @widget = Factory(:widget) }

  it "should be valid" do
    @widget.should be_valid
  end
end
