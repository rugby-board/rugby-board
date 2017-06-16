module Api
  module V1
    class NewsController < Api::V1::BaseController
      def item
        news = News.find(params[:id].to_i)
        result = {
          :news => {
            :id => news.id,
            :title => news.title,
            :content => news.content,
            :channel => news.channel,
            :channel_text => News::CHANNEL_LIST[news.channel][0],
            :event => news.event,
            :event_text => News::EVENT_LIST[news.event][0],
            :created_at => news.created_at
          }
        }
        render json: result
      end

      def list
        # get channels
        channel_id = get_channel_id(params[:channel])
        # get events
        event_id = get_event_id(params[:event])
        # paginating
        page = get_page(params[:p])
        start = (page - 1) * News::PAGINATION_STEP

        total = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]])
        news = News.where(status: [News::STATUS[:ok], News::STATUS[:highlighted]])

        unless channel_id.nil?
          total = total.where(channel: channel_id)
          news = news.where(channel: channel_id)
        end
        unless event_id.nil?
          total = total.where(event: event_id)
          news = news.where(event: event_id)
        end

        total = total.count
        news = news.reverse_order.limit(News::PAGINATION_STEP).offset(start)
        list = []
        news.each do |n|
          list << {
            :id => n.id,
            :title => n.title,
            :content => n.content,
            :channel => n.channel,
            :channel_text => News::CHANNEL_LIST[n.channel][0],
            :event => n.event,
            :event_text => News::EVENT_LIST[n.event][0],
            :created_at => n.created_at
          }
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

      private
      def get_page(page_param)
        page = page_param.to_i || 1
        page = 1 if page <= 0
        page
      end

      def get_channel_id(channel)
        return nil if channel.blank?

        channel
      end

      def get_event_id(event)
        return nil if event.blank?
        
        event
      end
    end
  end
end
