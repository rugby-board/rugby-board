class AdminController < ApplicationController
  include AuthHelper
  before_action :check_token

  def index
    @token = token

    @recent_news = News.where(status: News::STATUS[:ok]).last(8).reverse
    @cur_time = Time.now.strftime("%H:%M %Y-%m-%d")
    unless params[:id] == nil
      @edit_news = News.find(params[:id].to_i)
    end
  end

  def create
    @news = News.new(params.require(:news).permit(:title, :content, :channel, :event, :tag))
    @news.channel = params[:channel]
    @news.event = params[:event]
    @news.status = 0
    if @news.save
      flash[:info] = "Create news successfully."
    else
      flash[:warning] = @news.errors.messages
    end
    redirect_to root_url
  end

  def delete
    params.require(:news).permit(:id)
    @news = News.find(params[:news][:id])
    @news.status = 1
    @news.save

    if @news.save
      flash[:info] = "Delete news #{@news.id} successfully."
    else
      flash[:warning] = @news.errors.messages
    end
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

    if @news.save
      flash[:info] = "Edit news #{@news.id} successfully."
    else
      flash[:warning] = @news.errors.messages
    end
    redirect_to root_url
  end

  def highlight
    params.require(:news).permit(:id)
    begin
      @news = News.find(params[:news][:id])

      if params["set-highlight"]
        @news.status = News::STATUS[:highlighted]
        flash[:info] = "Highlight news #{@news.id} set successfully."
      end

      if params["cancel-highlight"]
        @news.status = News::STATUS[:ok]
        flash[:info] = "Highlight news #{@news.id} cancelled successfully."
      end

      unless @news.save
        flash.delete(:info)
        flash[:warning] = @news.errors.messages
      end
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "Illegal id[#{params[:news][:id]}] input"
    end

    redirect_to root_url
  end

  def translate
    require "rugby-dict"

    input = params[:entry] || ""
    dict = RugbyDict::Dict.from_yaml
    names = RugbyDict::Dict.segment(input)

    query_result = []
    names.each do |word|
      t = dict.query_dict(word)
      query_result << t unless t.nil?
    end

    result = {
      :query => input,
      :translations => query_result,
    }

    render json: result
  end

  private
  def check_token
    unless params[:token].eql?(token)
      flash[:warning] = "No permission as an admin."
      redirect_to root_url
    end
  end
end
