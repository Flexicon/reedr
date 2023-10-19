# frozen_string_literal: true

FactoryBot.define do
  factory(:user) do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    confirmed_at { Time.zone.now }
  end

  factory(:feed) do
    title { 'Hogwarts Digital Newsletter' }
    subtitle { 'Unlocking the Magic, One Byte at a Time!' }
    # url { 'https://www.hogwarts.edu/news/rss' } # TODO: put this back in once VCR is setup
    url { 'https://www.rssboard.org/files/sample-rss-092.xml' }
    user { association(:user) }
    latest_id { nil }
  end
end
