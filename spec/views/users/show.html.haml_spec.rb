require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/show.html.haml" do
  fuzzy :users

  include UsersHelper
  
  before(:each) do
    # @user = mock_model(User)
    # @user.stub!(:full_name).and_return("MyString")
    # @user.stub!(:email).and_return("MyString")
    # @user.stub!(:password_digest).and_return("MyString")
    # @user.stub!(:type).and_return("MyString")
    # @user.stub!(:about).and_return("MyText")
    # @user.stub!(:links).and_return("MyText")
    # @user.stub!(:photo_id).and_return("1")
    # 
    # assigns[:user] = @user

    assigns[:user] = mock_model(User, fuzzy_users.generate_columns({
      :avatar? => true,
      :avatar => mock_model(Paperclip::Attachment, :url => '/images/photo.gif'),
      :password => 'test',
      :password_confirmation => 'test'
    }))
  end

  it "should render attributes in <p>" do
    render "/users/show.html.haml"
    # response.should have_text(/MyString/)
    # response.should have_text(/MyString/)
    # response.should have_text(/MyString/)
    # response.should have_text(/MyString/)
    # response.should have_text(/MyText/)
    # response.should have_text(/MyText/)
  end
end

