require 'spec_helper'

describe FavoritesController do
  login_user


  describe "#index" do
    before do
      @user = mock_model(User)
      @favorites = mock_model(Article)

      controller.stub!(:current_user).and_return(@user)
      @user.stub!(:favorites).and_return(@favorites)
    end

    it "finds the request articles for current user" do
      controller.should_receive(:current_user).and_return(@user)
      @user.should_receive(:favorites).and_return(@favorites)
      get :index, user_id: 1, format: :js
    end

    it "assigns the request articles to @favorites" do
      get :index, user_id: 1, format: :js
      assigns(:favorites).should == @favorites
    end

    it "renders the index template" do
      get :index, user_id: 1, format: :js
      response.should render_template(:index)
    end
  end

  describe "#create" do
    before do
      @user = mock_model(User)
      @article = mock_model(Article)

      Article.stub!(:where).and_return(@article)
      @article.stub!(:first).and_return(@article)
      UsersArticle.stub!(:create!)
      controller.stub!(:current_user).and_return(@user)
    end

    it "find the request article" do
      Article.should_receive(:where).with(id: "1").and_return(@article)
      @article.should_receive(:first).and_return(@article)
      post :create, user_id: 1, article_id: 1, format: :js
      assigns(:article).should == @article
    end

    it "builds a new favorite" do
      controller.should_receive(:current_user).and_return(@user)
      UsersArticle.should_receive(:create!).with(user: @user, article: @article)
      post :create, user_id: 1, article_id: 1, format: :js
    end

    it "renders the create template" do
      post :create, user_id: 1, article_id: 1, format: :js
      response.should render_template(:create)
    end
  end

  describe "#destroy" do
    before do
      @user = mock_model(User)
      @favorite = mock_model(UsersArticle)
      @article = mock_model(Article)

      Article.stub!(:where).and_return(@article)
      @article.stub!(:first).and_return(@article)
      UsersArticle.stub!(:where).and_return(@favorite)
      @favorite.stub!(:first).and_return(@favorite)
      @favorite.stub!(:destroy)
      controller.stub!(:current_user).and_return(@user)
    end

    it "finds the request article" do
      Article.should_receive(:where).with(id: "1").and_return(@article)
      @article.should_receive(:first).and_return(@article)
      delete :destroy, user_id: 1, article_id: 1, format: :js
      assigns(:article).should == @article
    end

    it "finds the request favorite" do
      UsersArticle.should_receive(:where).with(user_id: @user.id, article_id: @article.id).and_return(@favorite)
      @favorite.should_receive(:first).and_return(@favorite)
      delete :destroy, user_id: 1, article_id: 1, format: :js
    end

    it "removes the request favorite" do
      @favorite.should_receive(:destroy)
      delete :destroy, user_id: 1, article_id: 1, format: :js
    end

    it "renders the destroy template" do
      delete :destroy, user_id: 1, article_id: 1, format: :js
      response.should render_template(:destroy)
    end
  end
end
