# frozen_string_literal: true

class BidSerializer < ApplicationSerializer
  attributes :id, :name, :status, :created_at

  attribute :transactions, if: :bid_owner?
  attribute :descriptions, if: :show?
  attribute :bid_owner, if: :show?
  attribute :amount

  def show?
    scope[:show].present? && scope[:show]
  end

  def show_amount
    object.accepted? || bid_owner?
  end

  def bid_owner
    bid_owner?
  end

  def bid_owner?
    scope[:bid_owner].present? && scope[:bid_owner] && scope[:show]
  end

  def transactions
    object.transactions.map do |i|
      TransactionSerializer.new(i)
    end
  end

  def descriptions
    object.descriptions.map do |i|
      DescriptionSerializer.new(i)
    end
  end
end
