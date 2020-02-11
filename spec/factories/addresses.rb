FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name  }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    zip { FFaker::AddressAU.postcode }
    country { %w[Ukraine Germane USA UK].sample }
    phone { FFaker::PhoneNumberAU.international_mobile_phone_number }
    type { 'shipping' }
    use_billing_address { true }
    addressable { association(:user) }
  end
end