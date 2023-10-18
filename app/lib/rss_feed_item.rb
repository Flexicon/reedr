# frozen_string_literal: true

RSSFeedItem = Struct.new(:id, :title, :link, :description) do
  def hexdigest
    Digest::MD5.hexdigest("#{id}_#{title}_#{link}_#{description}")
  end
end
