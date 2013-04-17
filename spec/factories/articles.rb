# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :article do
    title "MyString"
    link "MyString"
    description "MyText"
    publicated_at "2013-04-16 14:32:01"
    channel_id 1
  end
end
