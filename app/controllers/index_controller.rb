class IndexController < ApplicationController
  def index
    @news = News.all.reverse_order
  end
end
