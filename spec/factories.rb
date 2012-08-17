FactoryGirl.define do
  sequence :project_name do |n|
    "Project #{n}"
  end

  factory :user do |f|
    f.full_name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.password { "password" }
    f.password_confirmation { "password" }
    f.about { Faker::Lorem.paragraph }
    f.links { "http://" + Faker::Internet.domain_name }
    f.github_username { Faker::Name.last_name.underscore }
    f.started_using_ruby_on { 3.years.ago }
    f.neighborhood { ["North Park", "South Park", "University Heights", "Hillcrest"].sample }
    f.available_for_work true

    factory :user_with_avatar do |f|
      f.avatar { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "user_avatar.jpg").to_s, "image/jpeg") }
    end

    factory :admin do |f|
      f.admin true
    end
  end

  factory :event do |f|
    f.sequence(:name) {|n| "Event #{n}" }
    f.description { Faker::Lorem.paragraph }
    f.starts_at { 12.days.from_now }
    f.ends_at { 13.days.from_now }
    f.is_private false

    factory :private_event do |f|
      f.is_private true
    end
  end

  factory :podcast do |f|
    f.sequence(:name) {|n| "Podcast #{n}" }
    f.description { Faker::Lorem.paragraph }
    f.movie_link "http://sdruby.org"
    f.publish true
    f.screenshot { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "files", "podcast_screenshot.png").to_s, "image/png") }
  end

  factory :project do |f|
    f.association :user
    f.name { FactoryGirl.generate( :project_name ) }
    f.description { Faker::Lorem.paragraph }
  end
end
