# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    sequence(:title) { |n| "My title #{n}"}
    link "http://www.google.com"
    description "MyText"
    published_at "2013-04-16 14:32:01"
    channel_id 1
  end
end
