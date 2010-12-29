require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  it { should have_many(:jobs) }
  it { should have_many(:projects) }

  before { @user = Factory(:user, :full_name => "Snoop Dog") }

  it "should be valid" do
    @user.should be_valid
  end
  
  it "should expose #first_name" do
    @user.first_name.should == "Snoop"
  end

  it "should expose #last_name" do
    @user.last_name.should == "Dog"
  end 

  describe "validations" do
    it "should be invalid when full_name is nil, blank, or too short" do
      Factory.build(:user, :full_name => nil).should_not be_valid
      Factory.build(:user, :full_name => '').should_not be_valid
      Factory.build(:user, :full_name => 'A').should_not be_valid
    end

    it "should be invalid if email is taken" do
      Factory.create(:user, :email => "dude@awesome.com")
      Factory.build(:user, :email => "dude@awesome.com").should_not be_valid
    end

    it "should be invalid when email is nil, blank, or wrong format" do
      Factory.build(:user, :email => nil).should_not be_valid
      Factory.build(:user, :email => '').should_not be_valid
      Factory.build(:user, :email => 'asdf jdaskj@ askdjfkasdjf .com').should_not be_valid
    end

    it "should be invalid when password/password_confirmation are nil, blank, or too short" do
      Factory.build(:user, :password => nil).should_not be_valid
      Factory.build(:user, :password_confirmation => nil).should_not be_valid
      Factory.build(:user, :password => '').should_not be_valid
      Factory.build(:user, :password_confirmation => '').should_not be_valid
      Factory.build(:user, :password => 'asd').should_not be_valid
      Factory.build(:user, :password_confirmation => 'asd').should_not be_valid
    end

    it "should be invalid when password and password_confirmation are not equal" do
      Factory.build(:user, :password => 'tesT', :password_confirmation => 'test').should_not be_valid
    end
  end

  describe "after saving" do
    before { @user.save }

    it "should have generated a salt" do
      @user.password_salt.should_not be_blank
    end
  end

end
