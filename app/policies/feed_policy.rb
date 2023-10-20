# frozen_string_literal: true

class FeedPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where(user:)
    end
  end
end
