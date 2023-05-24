# require 'reform/form/dry'
require 'reform/form/active_model/validations'
module Post::Contract
  class Create < Reform::Form
    include ActiveModel::Validations

    property :title
    property :content
    property :category_id
    property :user_id
    property :image
    property :image_cache

    validates :title, presence: { message: "Title can't be blank!" }
    validates :content, presence: { message: "Content can't be blank!" },
                        length: { minimum: 25, too_short: '%<count>s characters is the minimum allowed' }
    validates :category_id, presence: { message: 'choose one category!' }
    validates :image, presence: { message: 'Image is required!' }, file_size: { less_than: 2.megabytes },
                      file_content_type: { allow: ['image/jpeg', 'image/png', 'image/gif'] }
  end
end
