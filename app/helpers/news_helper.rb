module NewsHelper
  TABLE_SEPARATOR = "|----|----|----|\n".freeze
  TABLE_SEPARATOR_CRLF = "|----|----|----|\r\n".freeze

  def filter_translation(data)
    table_head, table_body = parse_table(data[:content])
    return data if table_head.nil? || table_body.nil?

    new_body = ""
    table_body.split("|").each_with_index do |field, index|
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
    end

    new_content = table_head + TABLE_SEPARATOR + new_body
    data[:content] = new_content
    data
  end

  def balance_score(content)
    table_head, table_body = parse_table(content)
    return content if table_head.nil? || table_body.nil?

    new_body = ""
    table_body.split("|").each_with_index do |field, index|
      unless index == 0
        mod = index.modulo(4)
        if mod == 2
          new_field = ""
          scores = field.strip.split("-")
          if scores.length == 2
            score0 = scores[0]
            score1 = scores[1]
            if score0.length == score1.length
              new_field = field
            else
              largerScoreWidth = [score0.length, score1.length].max
              newScore0 = score0
              newScore1 = score1
              newScore0 = '&nbsp;' * (largerScoreWidth - newScore0.length) + score0 if newScore0.length < largerScoreWidth
              newScore1 = score1 + '&nbsp;' * (largerScoreWidth - newScore1.length) if newScore1.length < largerScoreWidth
              new_field = "#{newScore0}-#{newScore1}"
            end
          end
          new_body << "|#{new_field}"
        elsif mod == 0
          new_body << "|\n"
        else
          new_body << "|#{field}"
        end
      end
    end

    new_content = table_head + TABLE_SEPARATOR + new_body
    content = new_content
    content
  end

  def get_page(page_param)
    page = page_param.to_i || 1
    page = 1 if page <= 0
    page
  end

  private
  def parse_table(content)
    table = content.split(TABLE_SEPARATOR)
    if (table.empty? || table.size < 2)
      table = content.split(TABLE_SEPARATOR_CRLF)
      if (table.empty? || table.size < 2)
        return nil, nil
      end
    end
    table_head = table[0]
    table_body = table[1]
    return table_head, table_body
  end
end
