# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "Foo first name"
    last_name "Foo last name"
    username "foo_username"
    sequence(:email) { |n| "user_#{n}@rss.com" }
    password "12345678"
    password_confirmation "12345678"
  end
end
