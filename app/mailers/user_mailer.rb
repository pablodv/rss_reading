class UserMailer < ActionMailer::Base
  default from: "support@rss-reading.com"

  def send_feeds(user, articles)
    @user = user
    @articles = articles
    mail(to: user.email, subject: "Your last feeds in RSS Reading")
  end
end
