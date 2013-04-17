require 'spec_helper'

describe ArticlesHelper do
  before do
    @user = FactoryGirl.create(:user)
    @article_1 = FactoryGirl.create(:article, title: "My Title 1")
    @article_2 = FactoryGirl.create(:article, title: "My Title 2")

    @user.favorites << @article_1
  end

  describe "link to favorite" do
    context "with article like favorite" do
      it "does render link to destroy favorite" do
        helper.link_to_favorite(@user, @article_1).should == "<a href=\"/users/#{@user.id}/favorite/#{@article_1.id}\" class=\"favorite\" data-method=\"delete\" data-remote=\"true\" rel=\"nofollow\"><i class=\"icon-star\"></i></a>"
      end
    end

    context "without article like favorite" do
      it "does render link to create a favorite" do
        helper.link_to_favorite(@user, @article_2).should == "<a href=\"/users/#{@user.id}/favorite/#{@article_2.id}\" class=\"favorite\" data-method=\"post\" data-remote=\"true\" rel=\"nofollow\"><i class=\"icon-star-empty\"></i></a>"
      end
    end
  end
end
