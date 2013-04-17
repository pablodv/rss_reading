class FavoritesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @favorites = current_user.favorites
  end

  def create
    @article = Article.where(id: params[:article_id]).first
    UsersArticle.create!(user: current_user, article: @article)
  end

  def destroy
    @article  = Article.where(id: params[:article_id]).first
    @favorite = UsersArticle.where(user_id: current_user.id, article_id: @article.id ).first
    @favorite.destroy
  end
end
