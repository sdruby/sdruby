# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :talk_suggestion do
    name "MyString"
    description "MyText"
    style "MyString"
    suggested_speaker "MyString"
    created_by ""
  end
end
