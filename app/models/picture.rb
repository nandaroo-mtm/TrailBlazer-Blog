class Picture < ApplicationRecord
  include ImageUploader::Attachment(:image)
  belongs_to :imageable, polymorphic: true, optional: true, autosave: true
end
