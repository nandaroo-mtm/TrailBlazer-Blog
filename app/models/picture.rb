class Picture < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :post, optional: true, autosave: true
end
