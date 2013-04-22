require 'spec_helper'

describe Article do
  describe "Associations" do
    it { should belong_to :channel }
    it { should have_many :users_articles }
  end

  describe "Validations" do
    describe "Mandatories" do
      it { should validate_presence_of :title }
      it { should validate_presence_of :link }
      it { should validate_presence_of :description }
      it { should validate_presence_of :published_at }
      it { should validate_presence_of :channel_id }
    end

    describe "Uniqness" do
      it { should validate_uniqueness_of(:title).scoped_to(:channel_id) }
    end
  end

  describe "Instace Methods" do
    describe "search" do
      before do
        Article.tire.index.delete
        Article.create_elasticsearch_index

        @article_1 = FactoryGirl.create(:article, description: "Ruby on Rails Chapter #1", published_at: 2.day.ago)
        @article_2 = FactoryGirl.create(:article, description: "Ruby on Rails Chapter #2", published_at: Time.now)
        @article_3 = FactoryGirl.create(:article, description: "Ruby on Rails Chapter #3", published_at: 2.day.from_now)
        @article_4 = FactoryGirl.create(:article, description: "PHP Chapter #3", published_at: 2.day.from_now)

        Article.all.each{ |a| a.tire.update_index }
        Article.tire.index.refresh

        @articles = Article.search({query: "Rails"})
      end

      it "has resutls" do
        @articles.count.should == 3
      end

      it "returns articles filters by content" do
        @articles.should include(@article_1)
        @articles.should include(@article_2)
        @articles.should include(@article_3)
      end

      it "roders articles by publication date" do
        @articles[0].should == @article_3
        @articles[2].should == @article_1
      end
    end
  end
end
