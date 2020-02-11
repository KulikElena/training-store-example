ActiveAdmin.register Review do
  permit_params :status
  actions :index, :show, :update, :edit

  action_item :approve, only: :show do
    link_to I18n.t('active_admin.to_approved'), approve_admin_review_path(review), method: :put unless review.approved?
  end

  action_item :unapprove, only: :show do
    link_to I18n.t('active_admin.to_unapproved'), approve_admin_review_path(review), method: :put if review.approved?
  end

  action_item :processed, only: :index do
    link_to I18n.t('active_admin.to_prcessed'), root_path, method: :get
  end

  member_action :approve, method: :put do
    review = Review.find_by(id: params[:id])
    if review.approved?
      review.to_unapprove!
      redirect_to admin_reviews_path, danger: I18n.t('active_admin.review_unapproved')
    else
      review.to_approve!
      redirect_to admin_reviews_path, notice: I18n.t('active_admin.review_approved')
    end
  end

  index do
    column :book
    column :title
    column :status
    column :user_id
    column :created_at
    column :updated_at
    actions defaults: false do |review|
      item I18n.t('active_admin.view'), admin_review_path(review)
    end
  end
end
