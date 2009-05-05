require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  fuzzy :users

  before(:each) do
    @attribute_defaults = {
      :password => 'test',
      :password_confirmation => 'test',
      :avatar_file_name => 'Pic 001.gif',
      :avatar_content_type => 'image/gif',
      :avatar_file_size => 3242
    }
  end

  it "should be valid" do
    new_user.should be_valid
  end

  it "should be invalid when full_name is nil, blank, or too short" do
    new_user(:full_name => nil).should_not be_valid
    new_user(:full_name => '').should_not be_valid
    new_user(:full_name => 'A').should_not be_valid
  end

  it "should be invalid if email is taken" do
    (user1 = new_user(:email => 'dude@awesome.com')).save
    new_user(:email => 'dude@awesome.com').should_not be_valid
  end

  it "should be invalid when email is nil, blank, or wrong format" do
    new_user(:email => nil).should_not be_valid
    new_user(:email => '').should_not be_valid
    new_user(:email => 'asdf jdaskj@ askdjfkasdjf .com').should_not be_valid
  end

  it "should be invalid when password/password_confirmation are nil, blank, or too short" do
    new_user(:password => nil).should_not be_valid
    new_user(:password_confirmation => nil).should_not be_valid
    new_user(:password => '').should_not be_valid
    new_user(:password_confirmation => '').should_not be_valid
    new_user(:password => 'asd').should_not be_valid
    new_user(:password_confirmation => 'asd').should_not be_valid
  end

  it "should be invalid when password and password_confirmation are not equal" do
    new_user(:password => 'tesT', :password_confirmation => 'test').should_not be_valid
  end

  it "should generate a salt after saving" do
    (user = new_user).save
    user.password_salt.should_not be_blank
  end

protected
  def new_user(options = {})
    User.new(fuzzy_users.generate_columns(@attribute_defaults.merge(options)))
  end
end
