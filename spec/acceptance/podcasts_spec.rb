require 'spec_helper'

feature "Podcasts" do
  let!(:podcast_1) { create(:podcast) }
  let!(:podcast_2) { create(:podcast) }

  scenario "Viewing the Podcasts Listing" do
    visit root_path
    find("#navigation").click_link "Podcast"

    page.should have_selector("h1", :content => "SD Ruby Podcast")
    page.should have_selector("h2", :content => "Episode 00#{podcast_2.id}: #{podcast_2.name}")
    page.should have_selector("#episodes .episode", :count => 1)
  end
end
