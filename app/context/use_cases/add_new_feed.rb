# frozen_string_literal: true

module UseCases
  class AddNewFeed < ApplicationUseCase
    def initialize(url:, user:)
      @url = url
      @user = user
    end

    def call
      # TODO: lookup feed, interpolate title/subtitle and set latest_id
      Feed.create(title: 'feed-title-goes-here', url:, user:)
    end

    private

    attr_reader :url, :user
  end
end
