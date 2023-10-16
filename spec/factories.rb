# frozen_string_literal: true

FactoryBot.define do
  factory(:user) do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { Time.zone.now }
  end

  factory(:feed) do
    title { 'Hogwarts Digital Newsletter' }
    sub_title { 'Unlocking the Magic, One Byte at a Time!' }
    url { 'https://www.hogwarts.edu/news/rss' }
    user { association(:user) }
    latest_id { nil }
  end
end
