class GroupBuyingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    buyer?(user)
  end

  def user_items?
    buyer?(user)
  end

  def create?
    buyer?(user) && Time.current <= record.bidding_end_time && record.is_group_buying?
  end
end
