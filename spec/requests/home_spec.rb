# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home' do
  describe 'GET /' do
    it 'returns status 200' do
      get root_path
      expect(response).to have_http_status(:ok)
    end

    it 'sees the navbar header' do
      get root_path
      expect(response.body).to include('Reedr')
    end

    it 'sees the home page hero' do
      get root_path
      expect(response.body).to match(/Stay Groovy,<br>\s+Stay Updated/)
    end
  end
end
