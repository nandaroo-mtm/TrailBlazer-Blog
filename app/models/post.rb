class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  paginates_per 2
  include ImageUploader::Attachment.new(:image)
end
