require 'spec_helper'

feature "Members" do
  scenario "Viewing Members" do
    3.times { create(:user) }

    visit root_path
    find("#navigation").click_link "Members"
    page.should have_selector("tr.member", :count => 3)
  end

  scenario "Signing Up" do
    visit root_path
    find("#login").click_link "Signup"

    within "form#new_user" do
      fill_in "Full name:", :with => "Ben Hughes"
      fill_in "Email:", :with => "sdruby@bjh.me"
      fill_in "Password:", :with => "password"
      fill_in "Password confirmation:", :with => "password"
      click_button "Create account"
    end

    page.should have_selector("h1", :content => "Ben Hughes")
  end


  context "When Logged In" do
    let!(:user) { create(:user) }

    background do
      sign_in
    end

    scenario "Editing My Profile" do
      click_link "edit profile"

      fill_in "Tell us about you:", :with => "Test about."
      fill_in "Links:", :with => "http://sdruby.org\nhttp://jettingpenguin.com"
      fill_in "GitHub username:", :with => "rubiety"
      fill_in "What neighborhood do you live in?", :with => "North Park"
      fill_in "Full name:", :with => "Ben Renamed"
      click_button "Save changes"

      page.should have_selector("h1", :content => "Ben Renamed")
    end

    scenario "Deleting My Profile" do
      pending "awaiting jquery ujs" do
        click_link "delete profile"
        page.should have_content("Member profile deleted.")
      end
    end
  end

end

