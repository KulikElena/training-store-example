class BooksController < ApplicationController
  BOOKS_PER_PAGE = 12
  include Pagy::Backend
  decorates_assigned :book
  before_action :assign_variables, only: :index

  def index
    @pagy, @books = pagy(BooksQuery.new.call(params, @current_filter), items: BOOKS_PER_PAGE)
  end

  def show
    @book = Book.friendly.find(params[:id])
  end

  def books_params
    params.permit(:date_range, :max_price, :category, :selection, :untill_date)
  end

  private

  def assign_variables
    assign_date_variables
    @maximum_price ||= Book.maximum(:price)
    @minimum_price ||= Book.minimum(:price)
    @price = books_params[:max_price] || @maximum_price
    @authors = params[:author_ids] || []
    @category = books_params[:category]
    sort_filter = books_params[:selection]
    @current_filter = BooksQuery::FILTERS.values.include?(sort_filter) ? sort_filter : BooksQuery::FILTERS[:created_at_desc]
  end

  def assign_date_variables
    time_now = Time.zone.now.strftime('%Y/%m/%d').to_s
    @date_range = books_params[:date_range] || time_now + ' ' + time_now
    @range = books_params[:date_range] || time_now
    @untill_date = books_params[:untill_date] || time_now
  end
end
