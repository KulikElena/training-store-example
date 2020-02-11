class BookDecorator < Draper::Decorator
  delegate_all
  SHORT_DESCRIPTION_LENGTH = 100
  RAITING_STARS = (1..5).to_a.reverse

  def short_description
    description.first(SHORT_DESCRIPTION_LENGTH)
  end

  def all_reviews
    @all_reviews ||= reviews
  end

  def authors_all
    authors.map(&:full_name).join(', ')
  end
end
