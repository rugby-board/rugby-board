module NewsHelper
  def build_news(data)
    return "" if data.nil?
    if data.respond_to?(:id)
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
    else
      built_news = []
      data.each do |news|
        built_news.append(build_news(news))
      end
      built_news
    end
  end

  def get_page(page_param)
    page = page_param.to_i || 1
    page = 1 if page <= 0
    page
  end
end
