RSpec.describe 'Settings' do
  
  # Create an instance of SettingPage class and assign it to setting_page variable
  let(:setting_page) { SettingPage.new }
  let(:user) { create(:user) }

  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }
  let(:address) { FFaker::Address.street_address }
  let(:city) { FFaker::Address.city }
  let(:zip) { FFaker::AddressAU.postcode }
  let(:country) { %w[Ukraine Germane USA UK].sample }
  let(:phone) { FFaker::PhoneNumberAU.international_mobile_phone_number }

  # Login user and oper Settings page
  before do
    login_as(user)
    setting_page.load
  end

  context 'check shipping and billing address with valid data' do
    # Check that url http://localhost:2525/settings opened
    it { expect(setting_page).to be_displayed }
    # Check that all elements are displayed
    it { expect(setting_page).to be_all_there }
    # Check that title is correct
    it { expect(setting_page.title).to eq('Bookstore') }

    it 'fill in all data to shipping address with correct data' do
     setting_page.shipping_address_first_name.set(first_name)
     setting_page.shipping_address_last_name.set(last_name)
     setting_page.shipping_address_address.set(address)
     setting_page.shipping_address_city.set(city)
     setting_page.shipping_address_zip.set(zip)
     setting_page.shipping_address_country.select(country)
     setting_page.shipping_address_phone.set(phone)
     setting_page.shipping_address_button.click

     #expect(setting_page).to have_content(cannot_be_blank)
    end

    it 'fill in all data to billing address with correct data' do
     setting_page.billing_address_first_name.set(first_name)
     setting_page.billing_address_last_name.set(last_name)
     setting_page.billing_address_address.set(address)
     setting_page.billing_address_city.set(city)
     setting_page.billing_address_zip.set(zip)
     setting_page.billing_address_country.select(country)
     setting_page.billing_address_phone.set(phone)
     setting_page.billing_address_button.click
     end
  end

  context 'check shipping and billing address with invvalid data' do
    xit 'fill in all data to shipping address with incorrect data' do
      first_name = FFaker::Lorem.characters(rand(51..100))
      #puts first_name
      setting_page.shipping_address_first_name.set(first_name)
      setting_page.shipping_address_button.click
      #setting_page.shipping_address_first_name_validation.to eq("is too long (maximum is 50 characters)")
    end
  end
end