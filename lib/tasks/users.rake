namespace :db do
  namespace :users do
    desc "Send to the users your five last feeds"

    task send_feeds: :environment  do
      User.find_each do |user|
         articles = user.articles.most_recents.limit(5)
         UserMailer.send_feeds(user, articles).deliver
      end
    end
  end
end