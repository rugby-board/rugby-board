class WikiController < ApplicationController
  attr_reader :page_title

  def event
  	@page_title = "Wiki | "
    render 'wiki/event'
  end
end
