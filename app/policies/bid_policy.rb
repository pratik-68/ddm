class BidPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def item_owner?
    return true if record.user == user

    GroupBuying.exists?(item: record, user: user) if record.is_group_buying?
  end

  def bid_owner?
    return true if record.item.user == user

    GroupBuying.exists?(item: record.item, user: user) if record.item.is_group_buying?
  end

  def index?
    seller?(user) || item_owner?
  end

  def show?
    seller?(user) || bid_owner?
  end

  def top_bids?
    seller?(user) && !item_owner?
  end

  def create?
    seller?(user) && !item_owner? &&
      record.bidding_start_time <= Time.current &&
      Time.current <= record.bidding_end_time
  end

  def reject?
    buyer?(user) && Time.current <= record.buffer_end_time && item_owner?
  end

  def like?
    buyer?(user) && Time.current <= record.buffer_end_time && item_owner?
  end

  def destroy?
    seller?(user)
  end
end
