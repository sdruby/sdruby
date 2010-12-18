Factory.define :job do
  f.association :user
  f.sequence(:title) {|n| "Job #{n}" }
  f.description { Faker::Lorem.paragraph }
  f.published true
  f.contract false
end

Factory.define :unpublished_job, :parent => :job do
  f.published false
end

Factory.define :contract_job, :parent => :job do
  f.contract true
end
