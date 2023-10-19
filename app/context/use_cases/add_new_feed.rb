# frozen_string_literal: true

module UseCases
  class AddNewFeed < ApplicationUseCase
    def initialize(url:, user:)
      @url = url
      @user = user
    end

    def call
      return validator unless validator.validate

      Feed.create(
        title: fetched_rss.title || 'N/A',
        subtitle: fetched_rss.subtitle,
        latest_id: fetched_rss.items.first&.hexdigest,
        url:,
        user:
      )
    end

    private

    attr_reader :url, :user

    def validator
      @validator ||= Feed.new(url:, user:)
    end

    def fetched_rss
      @fetched_rss ||= RSSFeedFetcher.fetch(url)
    end
  end
end
