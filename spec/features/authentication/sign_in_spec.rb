RSpec.describe 'SignIn' do
  # Create an instance of SignInPage class and assign it to sign_in_page variable
  let(:sign_in_page) { SignInPage.new }
  # Create an instance of HomePage class and assign it to home_page variable
  let(:home_page) { HomePage.new }

  # Create user
  let(:user) { create(:user) }

  # Open Sign In page
  before { sign_in_page.load }

  context 'when open page' do
    # Check that url localhost:3000/users/sign_in opened
    it { expect(sign_in_page).to be_displayed }
    # Check that email, password, and login_button elements are displayed
    it { expect(sign_in_page).to be_all_there }
    # Check that title is correct
    it { expect(sign_in_page.title).to eq('Bookstore') }
  end

  context 'with correct email and password' do
    it 'user logs in' do
      # Fill in user email
      sign_in_page.email.set(user.email)
      # Fill in user password
      sign_in_page.password.set(user.password)
      # Click Log In button
      sign_in_page.login_button.click

      # Check that Home page opened
      expect(home_page).to be_displayed
      # Check that success message is displayed
      expect(home_page.success_flash.text).to eq('Signed in successfully.')
      # Check that user email is displayed
      expect(home_page.user_email.text).to eq(user.email)
      # Check that Sign Up link is not displayed
      expect(home_page).to have_no_sign_up_link
      # Check that Login link is not displayed
      expect(home_page).to have_no_login_link
    end
  end
end
