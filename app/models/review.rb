class Review < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :book

  validates :book_id, presence: true
  validates :user_id, presence: true
  validates :body, presence: true
  validates :title, presence: true

  aasm column: :status do
    state :unapproved, initial: true
    state :approved

    event :to_approve do
      transitions from: :unapproved, to: :approved
    end

    event :to_unapprove do
      transitions from: :approved, to: :unapproved
    end
  end
end
