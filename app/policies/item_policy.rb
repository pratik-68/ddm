class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def user_items?
    buyer?(user)
  end

  def index?
    seller?(user)
  end

  def create?
    buyer?(user)
  end

  def show?
    seller?(user) || record.user_id == user.id || record.is_group_buying?
  end
end
