# frozen_string_literal: true

require 'application_system_test_case'

class FeedsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @feed = feeds(:one) # TODO: move this to factory bot instead of fixtures
    @user = FactoryBot.create(:user)
    sign_in @user
  end

  test 'visiting the index' do
    visit feeds_url
    assert_selector 'h1', text: 'My Feeds'
  end

  test 'should create feed' do
    visit feeds_url
    click_link 'New feed'

    fill_in 'Url', with: @feed.url
    click_button 'Create Feed'

    assert_text 'Feed was successfully created'
    click_link 'Back'
  end

  test 'should update Feed' do
    visit feed_url(@feed)
    click_link 'Edit', match: :first

    fill_in 'Title', with: "#{@feed.title} (1)"
    fill_in 'Sub title', with: @feed.sub_title
    fill_in 'Url', with: 'https://dummy.url.io/'
    click_button 'Update Feed'

    assert_text 'Feed was successfully updated'
    assert_text "#{@feed.title} (1)"
    assert_text 'https://dummy.url.io/'
    click_link 'Back'
  end

  test 'should destroy Feed' do
    visit edit_feed_url(@feed)
    click_button 'Destroy', match: :first

    assert_text 'Feed was successfully destroyed'
  end
end
