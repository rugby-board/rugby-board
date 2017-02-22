class NewsController < ApplicationController
  attr_reader :page_title

  def list
    page = params[:p].to_i || 1
    page = 1 if page <= 0
    total = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]]).count
    start = (page - 1) * News::PAGINATION_STEP

    @news = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]])
                .reverse_order
                .limit(News::PAGINATION_STEP)
                .offset(start)
    
    @page = {
      :total => total,
      :cur_page => page,
      :total_page => (total.to_f/News::PAGINATION_STEP).ceil
    }
    @page_title = "News | "
  end

  def item
    @news = News.find(params[:id].to_i)
    @page_title = @news.page_title
  end

  def feed
    @news = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]]).last(News::PAGINATION_STEP).reverse
    render "news/feed.xml"
  end
end
