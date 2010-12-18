Factory.define :event do
  f.sequence(:name) {|n| "Event #{n}" }
  f.description { Faker::Lorem.paragraph }
  f.starts_at { 4.days.from_now }
  f.ends_at { 5.days.from_now }
end

Factory.define :private_event, :parent => :event do
  f.is_private true
end
