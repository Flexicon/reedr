# frozen_string_literal: true

require 'application_system_test_case'

class FeedsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @sample_feed_url = 'https://foo.bar.io/feed.rss'
    @user = FactoryBot.create(:user)
    @feed = FactoryBot.create(:feed, user: @user)
    sign_in @user

    VCR.insert_cassette('fetch_foo_bar_rss_feed')
  end

  teardown do
    VCR.eject_cassette
  end

  test 'visiting the index' do
    visit feeds_url
    assert_selector 'h1', text: 'My Feeds'
  end

  test 'should create feed' do
    visit feeds_url
    click_link 'Add feed'

    fill_in 'Url', with: @sample_feed_url
    click_button 'Submit'

    assert_text 'Feed was successfully created'
    click_link 'Back'
  end

  test 'should update Feed' do
    visit feed_url(@feed)
    click_link 'Edit', match: :first

    fill_in 'Title', with: "#{@feed.title} (1)"
    fill_in 'Subtitle', with: @feed.subtitle
    click_button 'Update'

    assert_text 'Feed was successfully updated'
    assert_text "#{@feed.title} (1)"
    assert_text @feed.url
    click_link 'Back'
  end

  test 'should destroy Feed' do
    visit edit_feed_url(@feed)
    accept_alert 'Are you sure you wish to delete this feed?' do
      click_button 'Destroy', match: :first
    end

    assert_text 'Feed was successfully destroyed'
  end
end
