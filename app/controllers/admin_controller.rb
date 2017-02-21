class AdminController < ApplicationController
  
  attr_reader :page_title

  before_action :check_token
  
  def index
    @token = token

    if params[:id] != nil
      @edit_news = News.find(params[:id].to_i)
    end

    @page_title = "Admin | "
  end

  def create
    @news = News.new(params.require(:news).permit(:title, :content, :channel, :event, :tag))
    @news.channel = params[:channel]
    @news.event = params[:event]
    @news.status = 0
    @news.save
  end

  def delete
    params.require(:news).permit(:id)
    @news = News.find(params[:news][:id])
    @news.status = 1
    @news.save
  end

  def edit
    params.require(:news).permit(:title, :content, :channel, :event, :tag)
    @news = News.find(params[:news][:id])
    @news.title = params[:news][:title]
    @news.content = params[:news][:content]
    @news.channel = params[:channel]
    @news.event = params[:event]
    @news.tag = params[:news][:tag]
    @news.save
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
