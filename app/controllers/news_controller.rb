class NewsController < ApplicationController
  attr_reader :page_title

  def list
    channel = params[:channel]
    if channel.blank?
      redirect_to "/404"
      return
    end

    channel_id = 0
    case channel
    when "news"
      channel_id = 0
      @page_title = "新闻 | "
    when "results"
      channel_id = 1
      @page_title = "比赛结果 | "
    else
      redirect_to "/404"
      return
    end

    page = params[:p].to_i || 1
    page = 1 if page <= 0

    total = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]], channel: channel_id).count
    start = (page - 1) * News::PAGINATION_STEP

    @news = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]], channel: channel_id)
                .reverse_order
                .limit(News::PAGINATION_STEP)
                .offset(start)
    
    @page = {
      :total => total,
      :cur_page => page,
      :total_page => (total.to_f/News::PAGINATION_STEP).ceil
    }
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
