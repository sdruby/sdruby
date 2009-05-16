require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Job do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :description => "value for description",
      :published => false,
      :contract => false,
      :user_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Job.create!(@valid_attributes)
  end
end
