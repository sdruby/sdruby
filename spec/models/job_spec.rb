require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Job do
  fixtures :jobs

  describe 'validations' do
    before do
    @valid_attributes = {
      :title => "BEST JOB EVAR",
      :description => "startup. no pay. generous equity. need ebay clone."
    }
    end

    it "should create a new instance given valid attributes" do
      Job.create!(@valid_attributes)
    end

    it 'should fail to createa  new instance given invalid attributes' do
      lambda { Job.create! }.should raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'instance methods' do
    before do
      @job = jobs(:my_great_job)
    end

    describe 'age' do
      it 'should describe the lapsed time in plain english' do
        @job.age.should == "2 days"      
      end
    end

    describe 'created_by?' do
      it 'returns true given the user who created the job' do
        @job.created_by?(users(:job_creating_rubyist)).should be_true
      end

      it 'returns false given any other user' do
        @job.created_by?(users(:loyal_rubyist)).should be_false
      end
    end
  end
end
