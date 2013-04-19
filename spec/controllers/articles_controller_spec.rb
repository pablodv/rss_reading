require 'spec_helper'

describe ArticlesController do
  login_user

  before do
    @channel  = mock_model(Channel)
    @articles = mock_model(Article)
    @user     = mock_model(User)

    controller.stub!(:current_user).and_return(@user)
    @user.stub!(:channels).and_return(@channel)
    @channel.stub!(:where).and_return(@channel)
    @channel.stub!(:first).and_return(@channel)
    @channel.stub!(:articles).and_return(@articles)
    @articles.stub!(:most_recents).and_return(@articles)
    @articles.stub!(:includes).and_return(@articles)
  end

  describe "#index" do
    it "finds the request channel" do
      controller.should_receive(:current_user).and_return(@user)
      @user.should_receive(:channels).and_return(@channel)
      @channel.should_receive(:where).with({id: "1"}).and_return(@channel)
      @channel.should_receive(:first).and_return(@channel)
      get :index, user_id: 1, channel_id: 1, format: :js
    end

    it "assigns the current channel to @channel" do
      get :index, user_id: 1, channel_id: 1, format: :js
      assigns(:channel).should == @channel
    end

    it "finds the articles of the current channel" do
      @channel.should_receive(:articles).and_return(@articles)
      @articles.should_receive(:most_recents).and_return(@articles)
      @articles.should_receive(:includes).with(:users_articles).and_return(@articles)
      get :index, user_id: 1, channel_id: 1, format: :js
    end

    it "assigns the current articles to @articles" do
      get :index, user_id: 1, channel_id: 1, format: :js
      assigns(:articles).should == @articles
    end

    it "responds with index template" do
      get :index, user_id: 1, channel_id: 1, format: :js
      response.should render_template(:index)
    end
  end
end
