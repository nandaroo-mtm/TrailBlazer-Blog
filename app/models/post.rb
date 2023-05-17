class Post < ApplicationRecord
  belongs_to :category
  paginates_per 2
  # include ImageUploader::Attachment(:image)
  include ImageUploader::Attachment.new(:image)
end
