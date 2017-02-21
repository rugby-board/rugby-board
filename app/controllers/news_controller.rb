class NewsController < ApplicationController
  attr_reader :page_title
  def admin
    check_token
    @token = token

    if params[:id] != nil
      @edit_news = News.find(params[:id].to_i)
    end

    @page_title = "Admin | "
  end

  def create
    check_token

    @news = News.new(params.require(:news).permit(:title, :content, :channel, :event, :tag))
    @news.channel = params[:channel]
    @news.event = params[:event]
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

  def edit
    check_token

    params.require(:news).permit(:title, :content, :channel, :event, :tag)
    @news = News.find(params[:news][:id])
    @news.title = params[:news][:title]
    @news.content = params[:news][:content]
    @news.channel = params[:channel]
    @news.event = params[:event]
    @news.tag = params[:news][:tag]
    @news.save
  end

  def list
    page = params[:p].to_i || 1
    page = 1 if page <= 0
    total = News.where(status: 0).count
    start = (page - 1) * News::PAGINATION_STEP
    @news = News.where(status: 0).reverse_order.limit(News::PAGINATION_STEP).offset(start)
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
    @news = News.where(status: 0).last(News::PAGINATION_STEP).reverse
    render "news/feed.xml"
  end

  private
  def check_token
    if !params[:token].eql? token
      redirect_to action: "index", controller: "index"
    end
  end

  def token
    ENV["ADMIN_TOKEN"] || "12ffbb6"
  end
end
