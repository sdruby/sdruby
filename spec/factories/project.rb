FactoryGirl.define do
  factory :project do |f|
    f.association :user
    f.sequence(:name) {|n| "Project #{n}" }
    f.description { Faker::Lorem.paragraph }
  end
end
