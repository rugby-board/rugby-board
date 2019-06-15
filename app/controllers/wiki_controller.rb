class WikiController < ApplicationController
  attr_reader :page_title

  def index
    @page_title = "Wiki | "
    render 'wiki/index'
  end

  def event
    @page_title = "Wiki | "
    event_sym = params[:event_name].to_sym
    @display_name = News::EVENT_WIKI_NAME_MAP[event_sym]
    if News::EVENT_WIKI_NAME_MAP.key?(event_sym)
      @event_name = params[:event_name].split("-").join("_")
      render 'wiki/event'
    else
      redirect_to "/404"
    end
  end
end
