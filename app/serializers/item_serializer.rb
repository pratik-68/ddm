class ItemSerializer < ApplicationSerializer
  attributes :id, :name, :quantity, :max_amount, :bidding_end_time, :status,
             :created_at
  attribute :bidding_start_time, if: :detail_view?
  attribute :winner_id, if: :detail_view? && :item_owner?
  attribute :item_owner?, key: :item_owner, if: :detail_view?
  attribute :group_buying?, key: :group_buying
  attribute :description, if: :detail_view?
  has_many :descriptions, if: :detail_view?

  def detail_view?
    scope[:detail].present? && scope[:detail]
  end

  def item_owner?
    scope[:item_owner].present? && scope[:item_owner]
  end

  def group_buying?
    object.is_group_buying?
  end
end
