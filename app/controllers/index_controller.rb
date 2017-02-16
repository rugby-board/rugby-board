class IndexController < ApplicationController
  def index
    @news = News.where(channel: 0, status: 0).last(20).reverse
  end

  def about
  	render "index/about"
  end

  def live
  	render "index/live"
  end
end
