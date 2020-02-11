class CreditCardForm
  include ActiveModel::Model
  include Virtus.model
  include ActiveModel::Validations::Callbacks

  attribute :number, String
  attribute :cvv, Integer
  attribute :name, String
  attribute :expiry_date, String

  validates :number, :cvv, :name, :expiry_date, presence: true

  validates :number,
            length: { is: 16 },
            format: { with: /\A[0-9]+\z/, message: I18n.t('forms.card_namber') }

  validates :name,
            length: { maximum: 50 },
            format: { with: /\A[a-z A-Z]+\z/, message: I18n.t('forms.card_name') }

  validates :expiry_date,
            length: { is: 5 },
            format: { with: %r{\A^(0[1-9]|1[0-2])\/?([0-9]{2})$\z}, message: I18n.t('forms.expiry_date') }

  validates :cvv,
            length: { in: 3..4 },
            numericality: { only_integer: true, message: I18n.t('forms.card_cvv') }

  validate :valid_expiy_date

  def valid_expiy_date
    if correct_expiry_date?
      expiry = Date.parse("20#{expiry_date.last(2)}-#{expiry_date.first(2)}-01")
      errors.add(:expiry_date, I18n.t('forms.expired_card_date')) unless Time.zone.now.strftime('%Y-%m-%d').to_date < expiry
    else
      errors.add(:expiry_date, I18n.t('forms.wrong_format_date_card'))
    end
  end

  def correct_expiry_date?
    include_range?(expiry_date.first(2), 12) && include_range?(expiry_date.last(2))
  end

  def include_range?(date, limit = 100)
    (1..limit).cover? date.to_i if date =~ /^\d{2}$/
  end

  def save(order)
    return false unless valid?

    order.build_credit_card
    update_credit_card(order)
  end

  def update_credit_card(order)
    order.credit_card.update(number: number,
                             cvv: cvv,
                             name: name,
                             expiry_date: expiry_date)
  end
end
