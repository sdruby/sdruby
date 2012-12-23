require 'spec_helper'

feature "Homepage" do
  let!(:podcast) { create(:podcast) }

  scenario "Viewing the Homepage" do
    visit root_path
    page.should have_selector(".homepage")
    page.should have_selector("h2", :content => "Latest from the SD Ruby Podcast")
    page.should have_content(podcast.name)
  end
end
