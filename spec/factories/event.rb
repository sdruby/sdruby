Factory.define :event do |f|
  f.sequence(:name) {|n| "Event #{n}" }
  f.description { Faker::Lorem.paragraph }
  f.starts_at { 12.days.from_now }
  f.ends_at { 13.days.from_now }
  f.is_private false
end

Factory.define :private_event, :parent => :event do |f|
  f.is_private true
end

Factory.define :meeting, :class => Meeting do |f|
end
