module Api
  module V1
    class SearchController < ApplicationController
      include NewsHelper

      def search
        title = params[:title]
        content = params[:content]
        channel = params[:channel].to_i
        event = params[:event].to_i
        startTime = params[:start_time]
        endTime = params[:end_time]

        page = get_page(params[:p])
        start = (page - 1) * News::PAGINATION_STEP

        # query title and content
        news = News.where.not(status: News::STATUS[:deleted])
        news = news.where(channel: channel) unless (channel.blank? || channel < 0)
        news = news.where(event: event) unless (event.blank? || event < 0)
        title_field = News.arel_table[:title]
        news = news.where(title_field.matches("%#{title}%")) unless title.blank?
        content_field = News.arel_table[:content]
        news = news.where(content_field.matches("%#{content}%")) unless content.blank?

        # make result
        total = news.count
        news = news.reverse_order.limit(News::PAGINATION_STEP).offset(start)

        list = []
        news.each do |n|
          list << build_news(n)
        end

        page = {
          :total => total,
          :cur_page => page,
          :total_page => (total.to_f/News::PAGINATION_STEP).ceil
        }

        result = {
          :page => page,
          :news => list
        }
        render json: result
      end
    end
  end
end
