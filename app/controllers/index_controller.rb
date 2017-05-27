class IndexController < ApplicationController
  attr_reader :page_title
  
  def index
    @highlight = News.where(status: News::STATUS[:highlighted])
                     .reverse_order
                     .limit(3)

    @news = News.where(status: News::STATUS[:ok], channel: 0)
                .last(News::PAGINATION_STEP)
                .reverse

    @results = News.where(status: News::STATUS[:ok], channel: 1)
                .last(News::PAGINATION_STEP)
                .reverse
  end

  def about
    @page_title = "About | "
    render "index/about"
  end

  def error_404
    @page_title = "Error | "
    render "errors/404"
  end
end
