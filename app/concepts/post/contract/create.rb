# require 'reform/form/dry'
require 'reform/form/active_model/validations'
module Post::Contract
  class Create < Reform::Form
    include ActiveModel::Validations

    property :title
    property :content
    property :category_id
    property :user_id
    property :pictures_attributes, virtual: true
    # property :image_data

    validates :title, presence: { message: "Title can't be blank!" }
    validates :content, presence: { message: "Content can't be blank!" },
                        length: { minimum: 25, too_short: '%<count>s characters is the minimum allowed' }
    validates :category_id, presence: { message: 'choose one category!' }
    validates :pictures_attributes, presence: { message: 'Image is required!' }
  end
end
