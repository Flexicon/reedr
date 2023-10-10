# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', type: :request do
  describe 'GET /' do
    it 'sees the home page' do
      get root_path
      expect(response).to have_http_status(200)
      expect(response.body).to include('Reedr')
      expect(response.body).to match(/Stay Groovy,<br>\s+Stay Updated/)
    end
  end
end
