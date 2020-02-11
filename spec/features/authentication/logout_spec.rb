RSpec.describe 'Logout user' do
  # Create an instance of HomePage class and assign it to home_page variable
  let(:home_page) { HomePage.new }
  let(:user) { create(:user) }

  # Create user
  user = FactoryBot.create(:user)

  # Login user
  before do
    login_as(user)
    home_page.load
  end

  context 'from header' do
    it 'dropdown' do
      # Hover on email
      home_page.user_email.hover

      # Click on logout button
      home_page.logout.click

      # Check that success message is displayed
      expect(home_page.success_flash.text).to eq('Signed out successfully.')
    end
  end
end