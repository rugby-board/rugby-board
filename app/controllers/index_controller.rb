class IndexController < ApplicationController
  def index
    @news = News.all.reverse_order
  end

  def about
  	render "index/about"
  end

  def live
  	render "index/live"
  end
end
