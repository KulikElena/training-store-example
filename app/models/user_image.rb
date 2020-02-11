class UserImage < ApplicationRecord
  belongs_to :user

  mount_uploader :image, UserImageUploader
end
