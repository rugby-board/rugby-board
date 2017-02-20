class News < ApplicationRecord
  PAGINATION_STEP = 20.freeze

  validates :title, length: {minimum: 2}

  def markdown_content
    require "kramdown"
    Kramdown::Document.new(content).to_html
  end

  def page_title
    "#{title} | "
  end
end
