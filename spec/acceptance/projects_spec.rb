require 'spec_helper'

feature "Projects" do
  [:member_1, :member_2].each do |name|
    let!(name) do
      FactoryGirl.create(:user).tap do |member|
        3.times { FactoryGirl.create(:project, :user => member) }
      end
    end
  end

  scenario "Viewing the Projects List" do
    visit root_path
    find("#navigation").click_link "Projects"

    page.should have_selector(".user .name a", :content => member_1.full_name)
    page.should have_selector(".user .name a", :content => member_2.full_name)
    page.should have_selector(".projects li", :count => 6)
    page.should have_selector("#featured_project")
  end
end

