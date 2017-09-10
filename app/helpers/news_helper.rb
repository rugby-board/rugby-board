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

  def filter_translation(data)
    table_separator = "|----|----|----|\n"
    table = data[:content].split(table_separator)
    if (table.empty? || table.size < 2)
      return data
    end
    table_head = table[0]
    table_body = table[1]
    new_body = ""
    index = 0
    table_body.split("|").each_with_index do |field|
      unless index == 0
        case index.modulo(4)
        when 1
          chinese_name = field.strip.split(" ").at(0)
          new_body << "|" + chinese_name
        when 2
          new_body << "|" + field
        when 3
          chinese_name = field.strip.split(" ").at(0)
          new_body << "|" + chinese_name
        when 0
          new_body << "|\n"
        end
        logger.error(new_body)
      end
      index += 1
    end
    new_content = table_head + table_separator + new_body
    data[:content] = new_content
    data
  end

  def get_page(page_param)
    page = page_param.to_i || 1
    page = 1 if page <= 0
    page
  end
end
