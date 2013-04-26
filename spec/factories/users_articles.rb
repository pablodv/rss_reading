# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :users_article do
    user
    article
  end
end
