# require 'reform/form/dry'
require 'reform/form/active_model/validations'
module Post::Contract
  class Update < Reform::Form
    include ActiveModel::Validations
    # include ImageUploader::Attachment(:image)

    property :title
    property :content
    property :category_id
    property :user_id
    property :pictures, virtual: true

    validates :title, presence: { message: "Title can't be blank!" }
    validates :content, presence: { message: "Content can't be blank!" },
                        length: { minimum: 25, too_short: '%<count>s characters is the minimum allowed' }
    validates :category_id, presence: { message: 'choose one category!' }
    # validates :pictures, presence: { message: 'Image is required!' }
  end
end
