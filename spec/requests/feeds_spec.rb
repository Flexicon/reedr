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
      expect(response.headers['Location']).to eq('http://www.example.com/auth/sign_in')
    end
  end

  describe 'GET /feeds authenticated' do
    include_context 'when logged in'

    it 'can access feeds page' do
      get feeds_path
      expect(response).to have_http_status(:ok)
    end

    it 'can see feeds page' do
      get feeds_path
      expect(response.body).to include('My Feeds')
    end
  end
end
