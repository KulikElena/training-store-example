RSpec.describe 'SignUp' do
  # Create an instance of SignUpPage class and assign it to sign_up_page variable
  let(:sign_up_page) { SignUpPage.new }
  # Create an instance of HomePage class and assign it to home_page variable
  let(:home_page) { HomePage.new }

  # Create fake data - email and password
  let(:user_email) { FFaker::Internet.email }
  let(:user_password) { FFaker::Internet.password }

  # Open Sign Up page
  before { sign_up_page.load }

  context 'when open page' do
    # Check that url localhost:3000/users/sign_up opened
    it { expect(sign_up_page).to be_displayed }
    # Check that email, password, password_confirmation and sign_up_button elements are displayed
    it { expect(sign_up_page).to be_all_there }
    # Check that title is correct
    it { expect(sign_up_page.title).to eq('Bookstore') }
  end

  context 'with valid data' do
    it 'user signs up' do
      # Fill in user email
      sign_up_page.email.set(user_email)
      # Fill in user password
      sign_up_page.password.set(user_password)
      # Fill in user password confirmation
      sign_up_page.password_confirmation.set(user_password)
      # Click Sign Up button
      sign_up_page.sign_up_button.click

      # Check that Home page opened
      expect(home_page).to be_displayed
      # Check that success message is displayed
      expect(home_page.success_flash.text).to eq('Welcome! You have signed up successfully.')
    end
  end
end
