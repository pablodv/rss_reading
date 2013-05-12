require 'spec_helper'

describe Article do
  describe "Associations" do
    it { should belong_to :channel }
    it { should have_many :users_articles }
    it { should have_many :comments }
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

  describe "Class Methods" do
    describe "search" do
      before do
        @article_1 = FactoryGirl.create(:article, description: "Ruby on Rails Chapter #1", published_at: 2.day.ago)
        @article_2 = FactoryGirl.create(:article, description: "Ruby on Rails Chapter #2", published_at: Time.now)
        @article_3 = FactoryGirl.create(:article, description: "Ruby on Rails Chapter #3", published_at: 2.day.from_now)
        @article_4 = FactoryGirl.create(:article, description: "PHP Chapter #3", published_at: 2.day.from_now)

        mock_request = "{\"query\":{\"query_string\":{\"query\":\"description:Rails\",\"default_operator\":\"AND\"}},\"sort\":[{\"published_at\":\"desc\"}],\"size\":10}"

        mock_response = "{\"took\": 9,\"timed_out\": false,
          \"_shards\": {\"total\": 5,\"successful\": 5,\"failed\": 0},\"hits\": {\"total\": 3,\"max_score\": null,
          \"hits\": ["

        [@article_3, @article_2 , @article_1].each do |a|
          mock_response << "{\"_index\": \"articles\",\"_type\": \"article\",\"_id\":\"#{a.id}\",\"_source\":#{a.to_json}}"
          mock_response << "," if a != @article_1
        end

        mock_response << "]}}"

        stub_request(:get, "http://localhost:9200/articles/article/_search?load=true&size=10").
          with(body: mock_request,
            headers: {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'124', 'User-Agent'=>'Ruby'}).
          to_return(status: 200, body: mock_response, headers: {})
      end

      let(:articles) { Article.search({query: "Rails"}) }

      it "has resutls" do
        articles.count.should == 3
      end

      it "returns articles filters by content" do
        articles.to_a.should include(@article_1)
        articles.to_a.should include(@article_2)
        articles.to_a.should include(@article_3)
        articles.to_a.should_not include(@article_4)
      end

      it "roders articles by publication date" do
        articles.to_a[0].should == @article_3
        articles.to_a[2].should == @article_1
      end
    end
  end
end
