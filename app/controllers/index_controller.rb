class IndexController < ApplicationController
  def index
    @news = News.where(channel: 0, status: 0).last(News::PAGINATION_STEP).reverse
  end

  def about
    @page_title = "About | "
    render "index/about"
  end
end
