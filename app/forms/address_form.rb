class AddressForm
  include ActiveModel::Model
  include Virtus.model

  attribute :first_name, String
  attribute :last_name, String
  attribute :address, String
  attribute :city, String
  attribute :zip, Integer
  attribute :country, Integer
  attribute :phone, String
  attribute :type, String
  attribute :use_billing_address, Boolean

  VALIDATE_FORMAT = {
    fields: /\A[a-z A-Z]+\z/,
    address: /\A[a-zA-Z0-9 \-\,]*\z/,
    zip: /\A[0-9\-]*\z/,
    phone: /\A\+[0-9]*\z/
  }.freeze

  ADDRESS_RANGE = (5..20).freeze

  validates :first_name, :last_name, :city, :country, :address, :zip, :phone, presence: true

  validates :address,
            length: { in: ADDRESS_RANGE },
            format: { with: VALIDATE_FORMAT[:address], message: I18n.t('forms.address') }
  validates :first_name, :last_name, :city,
            length: { maximum: 50 },
            format: { with: VALIDATE_FORMAT[:fields], message: I18n.t('forms.fields') }
  validates :zip,
            length: { maximum: 5 },
            format: { with: VALIDATE_FORMAT[:zip] },
            numericality: { only_integer: true, message: I18n.t('forms.zip') }
  validates :phone,
            length: { maximum: 13 },
            format: { with: VALIDATE_FORMAT[:phone], message: I18n.t('forms.phone') }

  def save_address(object, use_billing = false)
    valid? ? save(object, use_billing) : false
  end

  def save(object, use_billing)
    create_address(object)
    object.public_send(type).update(first_name: first_name,
                                    last_name: last_name,
                                    address: address,
                                    city: city,
                                    zip: zip,
                                    country: country,
                                    phone: phone,
                                    use_billing_address: use_billing)
  end

  def create_address(object)
    object.build_billing_address unless object.billing_address
    object.build_shipping_address unless object.shipping_address
  end
end
