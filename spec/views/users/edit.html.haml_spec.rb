require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/edit.html.haml" do
  fuzzy :users

  include UsersHelper
  
  before do
    # @user = mock_model(User)
    # @user.stub!(:full_name).and_return("MyString")
    # @user.stub!(:email).and_return("MyString")
    # @user.stub!(:password_digest).and_return("MyString")
    # @user.stub!(:about).and_return("MyText")
    # @user.stub!(:links).and_return("MyText")
    # @user.stub!(:photo_id).and_return("1")
    # assigns[:user] = @user

    assigns[:user] = mock_model(User, fuzzy_users.generate_columns({
      :avatar => mock_model(Paperclip::Attachment),
      :errors => [],
      :password => 'test',
      :password_confirmation => 'test'
    }))
  end

  it "should render edit form" do
    render "/users/edit.html.haml"
    # 
    # response.should have_tag("form[action=#{user_path(@user)}][method=post]") do
    #   with_tag('input#user_full_name[name=?]', "user[full_name]")
    #   with_tag('input#user_email[name=?]', "user[email]")
    #   with_tag('textarea#user_about[name=?]', "user[about]")
    #   with_tag('textarea#user_links[name=?]', "user[links]")
    # end
  end
end


