class Post < ApplicationRecord
  # self.belongs_to_required_by_default = false
  has_many :pictures, as: :imageable, dependent: :destroy, autosave: true
  belongs_to :user
  belongs_to :category
  accepts_nested_attributes_for :pictures, allow_destroy: true
  paginates_per 2
end
