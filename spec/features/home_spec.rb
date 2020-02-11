RSpec.describe 'Home' do
  # Create an instance of HomePage class and assign it to home_page variable
  let(:home_page) { HomePage.new }

  context 'without books' do
    # Open Home page
    before { visit '/' }

    it 'shows no books title' do
      # Check that Filters title is displayed
      expect(home_page.filters_title.text).to include('Filters')
      # Check that Catalog title is displayed
      expect(home_page.catalog_title.text).to include('Catalog')
      # Check that 'Can`t find books' title is displayed
      expect(home_page.no_books_title.text).to include('Can`t find books')
    end
  end

  context 'with books' do
    # Create category 'Mobile development'
    let(:mob) { create(:category, title: 'Mobile development') }
    # Create category 'Web development'
    let(:web) { create(:category, title: 'Web development') }

    # Create 7 books with category 'Mobile development'
    let!(:mob_books) { create_list(:book, 7, category: mob) }
    # Create 6 books with category 'Web development'
    let!(:web_books) { create_list(:book, 6, category: web) }

    # Open Home page
    before { visit '/' }

    it 'shows all books' do
      # Click on View More button
      home_page.view_more_button.click

      # Wait until View More button is disappeared
      home_page.has_no_view_more_button?

      # Check that all 13 books are displayed
      expect(home_page).to have_books(count: 13)
    end

    it 'shows pagination when more than 12 books created' do
      # Check that View More button is displayed if more than 12 books created
      expect(home_page).to have_view_more_button
    end
  end
end
