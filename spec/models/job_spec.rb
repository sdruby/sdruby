require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Job do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }

  before { @job = Factory(:job, :created_at => 2.days.ago) }

  it "should be valid" do
    @job.should be_valid
  end

  specify "#age should describe the lapsed time in plain english" do
    @job.age.should == "2 days"
  end

  specify "#created_by? with user who created the job should be true" do
    @job.created_by?(@job.user).should be_true
  end

  specify "#created_by? with another user should be false" do
    @job.created_by?(Factory.create(:user)).should be_false
  end
end
