class IndexController < ApplicationController
  attr_reader :page_title
  
  def index
    @highlight = News.where(status: News::STATUS[:highlighted])
                     .reverse_order
                     .limit(3)

    @news = News.where(status: News::STATUS[:ok])
                .last(News::PAGINATION_STEP)
                .reverse
  end

  def about
    @page_title = "About | "
    render "index/about"
  end
end
