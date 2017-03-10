class DumpToTwitterJob < ApplicationJob
  queue_as :default

  include NewsHelper

  def perform(*args)
    send_twitter
  end
end
