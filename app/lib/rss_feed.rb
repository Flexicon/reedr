# frozen_string_literal: true

class RSSFeed
  attr_reader :title, :items

  def initialize(feed:, is_atom:)
    if is_atom
      @title = feed.title.content
      @items = feed.items.map(&method(:build_atom_item))
    else
      @title = feed.channel.title
      @items = feed.items.map(&method(:build_rss_item))
    end
  end

  private

  def build_atom_item(item)
    RSSFeedItem.new(item.title.content, item.link.href)
  end

  def build_rss_item(item)
    RSSFeedItem.new(item.title, item.link)
  end
end
