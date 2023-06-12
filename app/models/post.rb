class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :pictures, dependent: :destroy, autosave: true
  accepts_nested_attributes_for :pictures, allow_destroy: true

  paginates_per 2
end
