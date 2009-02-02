require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/new.html.haml" do
  fuzzy :users

  include UsersHelper
  
  before(:each) do
    # @user = mock_model(User)
    # @user.stub!(:new_record?).and_return(true)
    # @user.stub!(:full_name).and_return("MyString")
    # @user.stub!(:email).and_return("MyString")
    # @user.stub!(:password_digest).and_return("MyString")
    # @user.stub!(:about).and_return("MyText")
    # @user.stub!(:links).and_return("MyText")
    # @user.stub!(:photo_id).and_return("1")
    # assigns[:user] = @user

    assigns[:user] = mock_model(User, fuzzy_users.generate_columns({
      :avatar => mock_model(Paperclip::Attachment, :url => '/images/photo.gif'),
      :errors => [],
      :password => 'test',
      :password_confirmation => 'test'
    }))
  end

  it "should render new form" do
    render "/users/new.html.haml"
    
    # response.should have_tag("form[action=?][method=post]", users_path) do
    #   with_tag("input#user_full_name[name=?]", "user[full_name]")
    #   with_tag("input#user_email[name=?]", "user[email]")
    #   with_tag("textarea#user_about[name=?]", "user[about]")
    #   with_tag("textarea#user_links[name=?]", "user[links]")
    # end
  end
end


