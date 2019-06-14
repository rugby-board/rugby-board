class IndexController < ApplicationController
  attr_reader :page_title

  def index
    @highlight = News.where(status: News::STATUS[:highlighted])
                     .reverse_order
                     .limit(3)

    @news = News.where(status: News::STATUS[:ok], channel: 0)
                .last(News::PAGINATION_STEP)
                .reverse

    @results = News.where(status: News::STATUS[:ok], channel: 1).where("created_at >= ?", 1.week.ago.utc)
                .last(News::PAGINATION_STEP)
                .reverse
    render "index/index"
  end

  def about
    @page_title = "关于 | "
    render "index/about"
  end

  def error_404
    @page_title = "页面不见了 | "
    render "errors/404"
  end
end
