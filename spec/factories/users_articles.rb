# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :users_article, :class => 'UsersArticles' do
    user_id 1
    article_id 1
  end
end
