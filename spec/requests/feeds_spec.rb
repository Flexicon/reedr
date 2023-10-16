# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Feeds' do
  describe 'GET /feeds unauthenticated' do
    it 'gets redirected to login page' do
      get feeds_path
      expect(response).to have_http_status(:found)
    end

    it 'gets redirected to login page url' do
      get feeds_path
      expect(response.headers['Location']).to eq(new_user_session_url)
    end
  end

  context 'when logged in' do
    include_context 'when logged in'

    describe 'GET /feeds authenticated' do
      it 'can access feeds page' do
        get feeds_path
        expect(response).to have_http_status(:ok)
      end

      it 'can see feeds page' do
        get feeds_path
        expect(response.body).to include('My Feeds')
      end
    end

    describe 'POST /feeds authenticated' do
      let(:feed_payload) { { url: 'https://foo.bar.io/feed.rss' } }

      it 'can create a new feed' do
        expect { post feeds_url, params: { feed: feed_payload } }
          .to change(Feed, :count).from(0).to(1)
      end

      it 'gets redirected to feed url' do
        post feeds_url, params: { feed: feed_payload }
        expect(response).to redirect_to(feed_url(Feed.last))
      end
    end

    describe 'GET /feeds/:id authenticated' do
      let(:feed) { create(:feed) }

      it 'can can access existing feed' do
        get feed_path(feed)
        expect(response).to have_http_status(:ok)
      end

      it 'can can see existing feed' do
        get feed_path(feed)
        expect(response.body).to include(feed.url)
      end
    end

    describe 'GET /feeds/:id/edit authenticated' do
      let(:feed) { create(:feed) }

      it 'can can access form for existing feed' do
        get edit_feed_path(feed)
        expect(response).to have_http_status(:ok)
      end

      it 'can can see existing feed form' do
        get edit_feed_path(feed)
        expect(response.body).to include(feed.url)
      end
    end

    describe 'PATCH /feeds/:id authenticated' do
      let(:feed) { create(:feed) }
      let(:update_feed_payload) { { title: 'New Feed Title' } }

      it 'can update existing feed' do
        expect { patch feed_url(feed), params: { feed: update_feed_payload } }
          .to change { feed.reload.title }
          .from(feed.title).to(update_feed_payload[:title])
      end

      it 'gets redirected to feed url' do
        patch feed_url(feed), params: { feed: update_feed_payload }
        expect(response).to redirect_to(feed_url(feed))
      end
    end

    describe 'DELETE /feeds/:id authenticated' do
      let!(:feed) { create(:feed) }

      it 'can delete a feed' do
        expect { delete feed_url(feed) }
          .to change(Feed, :count).from(1).to(0)
      end

      it 'gets redirected to feeds url' do
        delete feed_url(feed)
        expect(response).to redirect_to(feeds_url)
      end
    end
  end
end
