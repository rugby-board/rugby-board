class NewsController < ApplicationController
  def new
    @class_list = [
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

    if !params[:token].eql? "12ffbb6"
      redirect_to action: "index", controller: "index"
    end
  end

  def create
    @news = News.new(params.require(:news).permit(:title, :content, :klass, :event, :tag))
    @news.save

    redirect_to action: "news", controller: "list"
  end

  def list
  	@news = News.all.reverse_order
  end
end
