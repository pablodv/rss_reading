class ArticlesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @channel = current_user.channels.where(id: params[:channel_id]).first
    @articles = @channel.articles.most_recent
  end
end
