class SearchController < ApplicationController
  before_filter :authenticate_user!

  def index
    @channels = Channel.search(params)
    @articles = Article.search(params)
  end
end
