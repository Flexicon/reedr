# frozen_string_literal: true

RSpec.shared_context :logged_in do
  let(:user_to_sign_in) do
    (defined?(user) && user.presence) || FactoryBot.create(:user)
  end
  before { sign_in user_to_sign_in }
end
