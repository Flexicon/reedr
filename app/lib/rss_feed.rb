# frozen_string_literal: true

class RSSFeed
  attr_reader :title, :sub_title, :items

  def initialize(feed:, is_atom:)
    if is_atom
      @title = feed.title.content
      @sub_title = feed.subtitle.content
      @items = build_atom_items(feed.items)
    else
      @title = feed.channel.title
      @sub_title = feed.channel.description
      @items = build_rss_items(feed.items)
    end
  end

  private

  def build_atom_items(items)
    items.sort(&method(:sort_atom)).map(&method(:build_atom_item))
  end

  def build_rss_items(items)
    items.sort(&method(:sort_rss)).map(&method(:build_rss_item))
  end

  def sort_atom(first, second)
    second.updated.content <=> first.updated.content
  end

  def sort_rss(first, second)
    second.pubDate <=> first.pubDate
  end

  def build_atom_item(item)
    RSSFeedItem.new(item.id.content, item.title.content, item.link.href, item.summary.content)
  end

  def build_rss_item(item)
    RSSFeedItem.new(item.guid.content, item.title, item.link, item.description)
  end
end
