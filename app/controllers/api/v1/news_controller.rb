module Api
  module V1
    class NewsController < Api::V1::BaseController
      include AuthHelper
      before_action :check_token
      skip_before_action :verify_authenticity_token

      def home
        highlight = News.where(status: News::STATUS[:highlighted])
                     .reverse_order
                     .limit(3)
        news = News.where(status: News::STATUS[:ok], channel: 0)
                    .last(News::PAGINATION_STEP)
                    .reverse
        results = News.where(status: News::STATUS[:ok], channel: 1).where("created_at >= ?", 1.week.ago.utc)
                    .last(News::PAGINATION_STEP)
                    .reverse
        result = {
          :highlight => highlight.map {|n| build_news(n) },
          :news => news.map {|n| build_news(n) },
          :results => results.map {|n| build_news(n) }
        }

        render json: result
      end

      def create
        result = {}
        @news = News.new
        @news.title = params[:title]
        @news.content = params[:content]
        @news.channel = params[:channel]
        @news.event = params[:event]
        @news.tag = ""
        @news.status = 0
        if @news.save
          result = success_message(@news.id, "create")
          result[:news] = @news
        else
          result = error_message(0, "create", 1, @news.errors.messages)
        end

        render json: result
      end

      def update
        result = {}
        @news = News.find(params[:id])
        @news.title = params[:title]
        @news.content = params[:content]
        @news.channel = params[:channel]
        @news.event = params[:event]
        @news.tag = ""
        @news.save

        if @news.save
          result = success_message(@news.id, "update")
          result[:news] = @news
        else
          result = error_message(@news.id, "update", 1, @news.errors.messages)
        end

        render json: result
      end

      def destroy
        result = {}
        begin
          id = params[:id].to_i
          @news = News.find(id)
          @news.status = News::STATUS[:deleted]

          if @news.save
            result = success_message(id, "delete")
          else
            result = error_message(id, "delete", 1, @news.errors.messages)
          end
        rescue ActiveRecord::RecordNotFound
          result = error_message(id, "delete", 2, "Delete id not found")
        end

        render json: result
      end

      def show
        news = News.find(params[:id].to_i)
        result = {
          :news => build_news(news)
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

      def highlight
        result = {}
        begin
          id = params[:id].to_i
          @news = News.find(id)
          @news.status = News::STATUS[:highlighted]

          if @news.save
            result = success_message(id, "highlight")
          else
            result = error_message(id, "highlight", 1, "Highlight error")
          end
        rescue ActiveRecord::RecordNotFound
          result = error_message(id, "highlight", 2, @news.errors.messages)
        end

        render json: result
      end

      def unhighlight
        result = {}
        begin
          id = params[:id].to_i
          @news = News.find(id)
          @news.status = News::STATUS[:ok]

          if @news.save
            result = success_message(id, "unhighlight")
          else
            result = error_message(id, "unhighlight", 1, "Unhighlight error")
          end
        rescue ActiveRecord::RecordNotFound
          result = error_message(id, "unhighlight", 2, @news.errors.messages)
        end

        render json: result
      end

      private
      def success_message(id, action)
        {
          :status => 0,
          :id => id,
          :action => action
        }
      end

      def error_message(id, action, status, message)
        {
          :status => status,
          :id => id,
          :action => action,
          :message => message
        }
      end

      def build_news(data)
        {
          :id => data.id,
          :title => data.title,
          :content => data.content,
          :channel => data.channel,
          :channel_text => News::CHANNEL_LIST[data.channel][0],
          :event => data.event,
          :event_text => News::EVENT_LIST[data.event][0],
          :status => data.status,
          :created_at => data.created_at
        }
      end

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
