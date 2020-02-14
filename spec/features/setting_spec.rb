RSpec.describe 'Settings' do
  
  # Create an instance of SettingPage class and assign it to setting_page variable
  let(:setting_page) { SettingPage.new }
  let(:user) { create(:user) }
  #let(:address) { create(:address) }

  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }
  let(:address) { FFaker::Address.street_address }
  let(:city) { FFaker::Address.city }
  let(:zip) { FFaker::AddressAU.postcode }
  let(:country) { %w[Ukraine Germane USA UK].sample }
  let(:phone) { FFaker::PhoneNumberUA.international_mobile_phone_number.gsub!(/[\s-]/, '') }

  # Login user and oper Settings page
  before do
    login_as(user)
    setting_page.load
  end

  context 'check filling shipping and billing address with the valid data' do
    # Check that url http://localhost:2525/settings opened
    it { expect(setting_page).to be_displayed }
    # Check that all elements are displayed
    it { expect(setting_page).to be_all_there }
    # Check that title is correct
    it { expect(setting_page.title).to eq('Bookstore') }

    it 'fill in all correct data to shipping address' do
     setting_page.shipping_address_first_name.set(first_name)
     setting_page.shipping_address_last_name.set(last_name)
     setting_page.shipping_address_address.set(address)
     setting_page.shipping_address_city.set(city)
     setting_page.shipping_address_zip.set(zip)
     setting_page.shipping_address_country.select(country)
     setting_page.shipping_address_phone.set(phone)
     setting_page.shipping_address_button.click
    end

    it 'fill in all correct data to billing address' do
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

  context 'check shipping address with invvalid data' do
    it 'fill in shipping first name more than 50 characters' do
      first_name = FFaker::Lorem.characters(rand(51..100))
      setting_page.shipping_address_first_name.set(first_name)
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_first_name_validation.text).to eq("is too long (maximum is 50 characters)")
    end

    it 'empty first name in shipping' do
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_first_name_validation.text).to eq("can't be blank")
    end

    it 'fill in shipping last name more than 50 characters' do
      last_name = FFaker::Lorem.characters(rand(51..100))
      setting_page.shipping_address_last_name.set(last_name)
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_last_name_validation.text).to eq("is too long (maximum is 50 characters)")
    end

    it 'empty last name in shipping' do
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_last_name_validation.text).to eq("can't be blank")
    end

    it 'fill in shipping address more than 20 characters' do
      address = FFaker::Lorem.characters(rand(21..50))
      setting_page.shipping_address_address.set(address)
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_address_validation.text).to eq("is too long (maximum is 20 characters)")
    end

    it 'empty address in shipping' do
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_address_validation.text).to eq("can't be blank")
    end

    it 'fill in shipping city more than 50 characters' do
      city = FFaker::Lorem.characters(rand(51..100))
      setting_page.shipping_address_city.set(city)
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_city_validation.text).to eq("is too long (maximum is 50 characters)")
    end

    it 'empty city in shipping' do
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_city_validation.text).to eq("can't be blank")
    end

    it 'fill in zip more than 5 characters' do
      zip = rand(1000000..10000000)
      setting_page.shipping_address_zip.set(zip)
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_zip_validation.text).to eq("is too long (maximum is 5 characters)")
    end

    it 'empty zip in shipping' do
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_zip_validation.text).to eq("can't be blank")
    end

    it 'fill in zip with characters in shipping' do
      zip = FFaker::Lorem.characters(rand(1..5))
      setting_page.shipping_address_zip.set(zip)
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_zip_validation.text).to eq("is invalid")
    end

    it 'empty dropdown Country in shipping' do
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_country_validation.text).to eq("can't be blank")
    end

    it 'fill in phone with characters in shipping' do
      phone = FFaker::Lorem.characters(rand(5..13))
      setting_page.shipping_address_phone.set(phone)
      setting_page.shipping_address_button.click
      expect(setting_page.shipping_address_phone_validation.text).to eq("Phone must be format +38002353535")
    end

  end
end