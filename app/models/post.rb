class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  paginates_per 2

  mount_uploader :image, ImageUploader
end
