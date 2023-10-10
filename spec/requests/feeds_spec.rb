# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Feeds', type: :request do
  describe 'GET /feeds unauthenticated' do
    it 'gets redirected to login page' do
      get feeds_path
      expect(response).to have_http_status(302)
      expect(response.headers['Location']).to eq('http://www.example.com/auth/sign_in')
    end
  end

  describe 'GET /feeds authenticated' do
    include_context :logged_in

    it 'can access feeds page' do
      get feeds_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('My Feeds')
    end
  end
end
