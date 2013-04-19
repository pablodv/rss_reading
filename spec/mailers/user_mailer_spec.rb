require "spec_helper"

describe UserMailer do
  describe "send feeds" do
    let(:user){ FactoryGirl.create(:user) }
    let(:article){ FactoryGirl.create(:article) }

    subject { UserMailer.send_feeds(user, [article]) }

    it "sends the email with correct subject" do
      subject.subject.should eq("Your last feeds in RSS Reading")
    end

    it "sends the email to user email" do
      subject.from.should eq(["support@rss-reading.com"])
    end

    it "includes the correct text" do
      subject.body.encoded.should match(/Hello, #{user.first_name} we are sending your last feeds in RSS Reading./)
    end

    it "includes the article link" do
      subject.body.encoded.should match(/#{article.link}/)
    end

    it "includes the article description" do
      subject.body.encoded.should match(/#{article.description}/)
    end
  end
end
