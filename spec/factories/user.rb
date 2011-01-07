Factory.define :user do |f|
  f.full_name { Faker::Name.name }
  f.email { Faker::Internet.email }
  f.password { "password" }
  f.password_confirmation { "password" }
  f.about { Faker::Lorem.paragraph }
  f.links { "http://" + Faker::Internet.domain_name }
  f.avatar { ActionController::TestUploadedFile.new(Rails.root.join("spec", "files", "user_avatar.jpg").to_s, "image/jpeg") }  
  f.github_username { Faker::Name.last_name.underscore }
  f.started_using_ruby_on { 3.years.ago }
  f.neighborhood { ["North Park", "South Park", "University Heights", "Hillcrest"].sample }
  f.available_for_work true
end
