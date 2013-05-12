class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_article

  def new
    @comment = Comment.new(user_id: current_user.id, article_id: @article.id)
  end

  def create
    @comment = Comment.create(params[:comment])
  end

  private

  def find_article
    @article = Article.where(id: params[:article_id]).first
  end
end
