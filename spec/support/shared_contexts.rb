# frozen_string_literal: true

RSpec.shared_context 'when logged in' do
  let(:user_to_sign_in) do
    (defined?(user) && user.presence) || create(:user)
  end
  before { sign_in user_to_sign_in }
end
