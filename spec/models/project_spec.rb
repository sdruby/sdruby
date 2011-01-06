require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Project do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }

  before { @project = Factory(:project) }

  it "should be valid" do
    @project.should be_valid
  end
end
