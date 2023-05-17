# require 'reform/form/dry'
require "reform/form/active_model/validations"
module Post::Contract
    class Create < Reform::Form
        include ActiveModel::Validations
        include ImageUploader::Attachment(:image)
        # include ImageUploader::Attachment(:image, cache: :other_cache, store: :other_store)
        

        property :title
        property :content
        property :category_id
        property :image
        property :image_data
        
        validates :title, presence: { message: "Title can't be blank!" }
        validates :content, presence:  { message: "Content can't be blank!" },  length: { minimum: 25, too_short: "%{count} characters is the minimum allowed" }
        validates :category_id, presence: { message: "choose one category!" }
        validates :image, presence: { message: "Image is required!" }, file_size: {less_than: 2.megabytes}, file_content_type: {allow: ['image/jpeg', 'image/png', 'image/gif']}
    end
end