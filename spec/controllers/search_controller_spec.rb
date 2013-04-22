require 'spec_helper'

describe SearchController do
  login_user

  describe "#index" do
    before do
      @channels = mock_model(Channel)
      @articles = mock_model(Article)

      Channel.stub!(:search).and_return(@channels)
      Article.stub!(:search).and_return(@articles)
    end

    it "finds channels with request text" do
      Channel.should_receive(:search).and_return(@channels)
      get :index, format: :js
    end

    it "assigns the result to @channels" do
      get :index, format: :js
      assigns(:channels).should == @channels
    end

    it "finds articles with request text" do
      Article.should_receive(:search).and_return(@articles)
      get :index, format: :js
    end

    it "assigns the result to @articles" do
      get :index, format: :js
      assigns(:articles).should == @articles
    end
  end
end
