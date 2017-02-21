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

    redirect_to root_url
  end

  def delete
    params.require(:news).permit(:id)
    @news = News.find(params[:news][:id])
    @news.status = 1
    @news.save

    redirect_to root_url
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

    redirect_to root_url
  end

  private
  def check_token
    unless params[:token].eql?(token)
      flash[:error] = "No permission as an admin"
      redirect_to root_url
    end
  end

  def token
    ENV["ADMIN_TOKEN"] || "12ffbb6"
  end
end
