# frozen_string_literal: true

json.extract! feed, :id, :title, :sub_title, :url, :user_id, :latest_id, :created_at, :updated_at
json.url feed_url(feed, format: :json)
