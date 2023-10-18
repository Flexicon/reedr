# frozen_string_literal: true

RSSFeedItem = Struct.new(:title, :link) do
  def hexdigest
    Digest::MD5.hexdigest("#{title}_#{link}")
  end
end
