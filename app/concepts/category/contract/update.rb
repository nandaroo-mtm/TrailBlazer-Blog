# app/concepts/blog_post/operation/update.rb
module Category::Contract
  class Create < Reform::Form
    # feature Reform::Form::Dry

    property :name

    validates :name, presence: { message: "Category name can't be blank!" }
  end
end
