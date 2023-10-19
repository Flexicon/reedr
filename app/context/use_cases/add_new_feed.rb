# frozen_string_literal: true

module UseCases
  class AddNewFeed < ApplicationUseCase
    def initialize(url:, user:)
      @url = url
      @user = user
    end

    def call
      feed = Feed.new(url:, user:)
      return feed unless feed.validate

      feed.tap do |f|
        f.update(
          title: fetched_rss.title || 'N/A',
          subtitle: fetched_rss.subtitle,
          latest_id: fetched_rss.items.first&.hexdigest
        )
      end
    end

    private

    attr_reader :url, :user

    def fetched_rss
      @fetched_rss ||= RSSFeedFetcher.fetch(url)
    end
  end
end
