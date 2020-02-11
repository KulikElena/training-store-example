class ReviewsController < ApplicationController
  def create
    review = Review.new(review_params)
    if review.save
      review.to_approve!
      flash[:success] = t('review.saved_comment')
      redirect_to book_path(review.book.friendly_id)
    else
      flash[:danger] = t('review.wrong_comment')
      redirect_to request.headers['HTTP_REFERER']
    end
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :book_id, :title, :body, :score)
  end
end
