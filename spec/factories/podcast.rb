require "action_controller/test_process"

Factory.define :podcast do
  f.sequence(:name) {|n| "Podcast #{n}" }
  f.description { Faker::Lorem.paragraph }
  f.movie_link "http://sdruby.org"
  f.publish true
  f.screenshot { ActionController::TestUploadedFile.new(Rails.root.join("spec", "files", "podcast_screenshot.png").to_s, "image/png") }  
end
