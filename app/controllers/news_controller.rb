class NewsController < ApplicationController
  def admin
    check_token

    @channel_list = [
      ['News', 0],
      ['Event', 1],
      ['Live', 2],
      ['Meetup', 3]
    ].freeze

    @event_list = [
      ['None', 0],
      ['Test Matches', 1],
      ['SixNations', 2],
      ['Rugby Championship', 3],
      ['Super Rugby', 4],
      ['Premiership', 5],
      ['TOP 14', 6],
      ['PRO 12', 7],
      ['European Champions Cup', 8],
      ['Rugby World Cup', 9],
      ['British and Irish Lions', 10],
      ['European Challenge Cup', 11],
      ['Currie Cup', 12],
      ['Top League', 13],
      ['Rugby Sevens', 14]
    ].freeze
  end

  def create
    check_token

    @news = News.new(params.require(:news).permit(:title, :content, :channel, :event, :tag))
    @news.channel = params[:channel]
    @news.event = params[:event]
    @news.tag = params[:tag]
    @news.status = 0
    @news.save
  end

  def delete
    check_token

    params.require(:news).permit(:id)
    @news = News.find(params[:news][:id])
    @news.status = 1
    @news.save
  end

  def list
    page = params[:p].to_i || 1
    page = 1 if page <= 0
    total = News.where(channel: 0, status: 0).count
    start = (page - 1) * News::PAGINATION_STEP
    @news = News.where(channel: 0, status: 0).reverse_order.limit(News::PAGINATION_STEP).offset(start)
    @page = {
      :total => total,
      :cur_page => page,
      :total_page => (total/News::PAGINATION_STEP).ceil
    }
  end

  def feed
    @news = News.where(channel: 0, status: 0).last(News::PAGINATION_STEP).reverse
    render "news/feed.xml"
  end

  private
  def check_token
    if !params[:token].eql? "12ffbb6"
      redirect_to action: "index", controller: "index"
    end
  end
end
