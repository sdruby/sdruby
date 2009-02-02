require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/index.html.haml" do
  fuzzy :users

  include UsersHelper
  
  before(:each) do
    # user_98 = mock_model(User)
    # user_98.should_receive(:full_name).and_return("MyString")
    # user_98.should_receive(:email).and_return("MyString")
    # user_98.should_receive(:type).and_return("MyString")
    # user_98.should_receive(:about).and_return("MyText")
    # user_98.should_receive(:links).and_return("MyText")
    # user_99 = mock_model(User)
    # user_99.should_receive(:full_name).and_return("MyString")
    # user_99.should_receive(:email).and_return("MyString")
    # user_99.should_receive(:type).and_return("MyString")
    # user_99.should_receive(:about).and_return("MyText")
    # user_99.should_receive(:links).and_return("MyText")
    # 
    # assigns[:users] = [user_98, user_99]

    assigns[:users] = [
      mock_model(User, fuzzy_users.generate_columns({:avatar => mock_model(Paperclip::Attachment, :url => '/images/photo.gif')})),
      mock_model(User, fuzzy_users.generate_columns({:avatar => mock_model(Paperclip::Attachment, :url => '/images/photo.gif')}))
    ]
  end

  it "should render list of users" do
    render "/users/index.html.haml"
    # response.should have_tag("tr>td", "MyString", 2)
    # response.should have_tag("tr>td", "MyString", 2)
    # response.should have_tag("tr>td", "MyString", 2)
    # response.should have_tag("tr>td", "MyString", 2)
    # response.should have_tag("tr>td", "MyText", 2)
    # response.should have_tag("tr>td", "MyText", 2)
  end
end

