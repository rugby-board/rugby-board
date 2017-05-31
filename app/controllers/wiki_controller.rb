class WikiController < ApplicationController
  attr_reader :page_title

  AVAILABLE_EVENTS = {
  	:the_rugby_championship => true,
  	:six_nations => true,
  	:rugby_world_cup => true,
  	:super_rugby => true,
  	:pro12_rugby => true,
  	:premiership_rugby => true,
  	:top14_rugby => true
  }.freeze

  def index
    @page_title = "Wiki | "
    render 'wiki/index'
  end

  def event
    @page_title = "Wiki | "
    @event_name = params[:event_name].split("-").join("_")
    event_sym = @event_name.to_sym
    if AVAILABLE_EVENTS.key?(event_sym)
      render 'wiki/event'
    else
      redirect_to "/404"
    end
  end
end
