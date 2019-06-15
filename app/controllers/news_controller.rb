class NewsController < ApplicationController
  attr_reader :page_title

  def list
    # get channels
    channel_id = get_channel_id(params[:channel])
    if channel_id.nil?
      redirect_to "/404"
      return
    end
    # get events
    event_id = get_event_id(params[:event_name])
    # proceed params
    page = get_page(params[:p])
    start = (page - 1) * News::PAGINATION_STEP
    # get news
    if event_id == false
      redirect_to "/404"
      return
    elsif event_id.nil?
      total = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]], channel: channel_id)
                  .count
      @news = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]], channel: channel_id)
                  .reverse_order.limit(News::PAGINATION_STEP).offset(start)
    else
      @event_name = params[:event_name]
      @wiki = true if News::WIKI_AVAILABILITY.key?(params[:event_name].to_sym)
      total = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]], channel: channel_id, event: event_id)
                  .count
      @news = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]], channel: channel_id, event: event_id)
                  .reverse_order.limit(News::PAGINATION_STEP).offset(start)
    end

    @page = {
      :total => total,
      :cur_page => page,
      :total_page => (total.to_f/News::PAGINATION_STEP).ceil
    }

    set_page_title(channel_id, event_id)
  end

  def item
    param_id = params[:id].to_i
    @news = News.find(param_id)
    @page_title = @news.page_title
    @adjacent = News.where(id: [param_id - 1, param_id + 1])
    not_available_ids = Array.new
    not_available_ids << @news.id
    @adjacent.each do |n|
      not_available_ids << n.id
    end
    @related = News.where(event: @news.event).where.not(id: not_available_ids).last(2).reverse
  end

  def feed
    @news = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]]).last(News::PAGINATION_STEP).reverse
    render "news/feed.xml"
  end

  private
  def get_page(page_param)
    page = page_param.to_i || 1
    page = 1 if page <= 0
    page
  end

  def get_channel_id(channel_param)
    channel = channel_param.to_s
    return nil if channel.blank?

    channel_id = nil
    case channel
    when "news"
      channel_id = 0
    when "results"
      channel_id = 1
    when "events"
      channel_id = [0, 1]
    else
      return nil
    end

    channel_id
  end

  def get_event_id(event_name)
    return nil if event_name.blank?
    event_sym = event_name.to_sym
    return News::EVENT_NAME_ID_MAP[event_sym] if News::EVENT_NAME_ID_MAP.key?(event_sym)

    false
  end

  def set_page_title(channel_id, event_id)
    if channel_id == 0
      @page_title = "新闻 | "
      @page_icon = "fw fa-newspaper-o"
      @in_page_title = "新闻"
    elsif channel_id == 1
      @page_title = "比分 | "
      @page_icon = "fw fa-table"
      @in_page_title = "比分"
    end

    unless event_id.nil?
      @page_title = "#{News::EVENT_LIST[event_id][0]} | "
      @page_icon = "fw fa-flag-checkered"
      @in_page_title = "#{News::EVENT_LIST[event_id][0]}"
      event_sym = params[:event_name].to_sym
      @in_page_title = News::EVENT_NAME_MAP[event_sym]
    end
  end
end
