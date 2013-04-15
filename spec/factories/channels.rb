# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :channel do
    user
    url "http://www.foo.com"
    name "My channel"
  end
end
