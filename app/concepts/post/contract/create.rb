# require 'reform/form/dry'
require 'reform/form/active_model/validations'
module Post::Contract
  class Create < Reform::Form
    include ImageUploader::Attachment(:image)
    include ActiveModel::Validations
    # include ImageUploader::Attachment(:image, cache: :other_cache, store: :other_store)


    property :title
    property :content
    property :category_id
    property :user_id
    # property :image, virtual: true
    property :pictures_attributes, virtual: true

    validates :title, presence: { message: "Title can't be blank!" }
    validates :content, presence: { message: "Content can't be blank!" },
                        length: { minimum: 25, too_short: '%<count>s characters is the minimum allowed' }
    validates :category_id, presence: { message: 'choose one category!' }
    # validates :image, presence: { message: 'Image is required!' }, file_size: { less_than: 2.megabytes },
    #                   file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }
    validates :pictures_attributes, presence: { message: 'Image is required!' }
  end
end
