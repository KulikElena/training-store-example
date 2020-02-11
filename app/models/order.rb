require 'aasm'
class Order < ApplicationRecord
  include AASM

  belongs_to :user
  has_one :delivery_service, dependent: :destroy
  has_many :order_items, dependent: :destroy
  has_one :billing_address, as: :addressable, dependent: :destroy
  has_one :shipping_address, as: :addressable, dependent: :destroy
  has_one :credit_card, dependent: :destroy

  aasm :status, column: :status do
    state :in_progress, initial: true
    state :processing
    state :shipped
    state :delivered
    state :canceled

    event :to_processing do
      transitions from: :in_progress, to: :processing
    end

    event :to_shipped do
      transitions from: :processing, to: :shipped
    end

    event :to_delivered do
      transitions from: :shipped, to: :delivered
    end

    event :to_canceled do
      transitions from: :delivered, to: :canceled
    end
  end

  aasm :checkout, column: :checkout do
    state :address, initial: true
    state :delivery
    state :payment
    state :confirm
    state :complete

    event :to_delivery do
      transitions from: :address, to: :delivery
    end

    event :to_payment do
      transitions from: :delivery, to: :payment
    end

    event :to_confirm do
      transitions from: :payment, to: :confirm
    end

    event :to_complete do
      transitions from: :confirm, to: :complete
    end
  end
end
