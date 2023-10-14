# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Feeds' do
  describe 'GET /feeds unauthenticated' do
    it 'gets redirected to login page' do
      get feeds_path
      expect(response).to have_http_status(:found)
      expect(response.headers['Location']).to eq('http://www.example.com/auth/sign_in')
    end
  end

  describe 'GET /feeds authenticated' do
    include_context 'logged in'

    it 'can access feeds page' do
      get feeds_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('My Feeds')
    end
  end
end
