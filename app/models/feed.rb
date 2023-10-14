# frozen_string_literal: true

class Feed < ApplicationRecord
  belongs_to :user

  validates :url, presence: true, uniqueness: {
    scope: :user_id,
    message: I18n.t('feeds.feed_uniqueness_validation_message'),
    allow_blank: true
  }, http_url: {
    allow_blank: true
  }
end
