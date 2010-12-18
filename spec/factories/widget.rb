Factory.define :widget do |f|
  f.setup "Setup"
  f.sequence(:column) {|n| n }
  f.sequence(:row) {|n| n }
  f.view { Faker::Lorem.paragraph }
end
