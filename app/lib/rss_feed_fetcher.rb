# frozen_string_literal: true

require 'rss'

class RSSFeedFetcher
  def self.fetch(url)
    new.fetch(url)
  end

  def fetch(url)
    feed = RSS::Parser.parse(Faraday.get(url).body, false)
    RSSFeed.new(feed:, is_atom: feed.is_a?(RSS::Atom::Feed))
  end
end
