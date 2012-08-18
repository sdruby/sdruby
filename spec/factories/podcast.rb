FactoryGirl.define do
  factory :podcast do |f|
    f.sequence(:name) {|n| "Podcast #{n}" }
    f.description { Faker::Lorem.paragraph }
    f.movie_link "http://sdruby.org"
    f.publish true
    f.screenshot { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "podcast_screenshot.png").to_s, "image/png") }
  end
end
