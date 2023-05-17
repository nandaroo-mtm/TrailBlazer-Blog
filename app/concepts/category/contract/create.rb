# require 'reform/form/dry'
# require "reform/form/active_model/validations"
module Category::Contract
    class Create < Reform::Form
        # feature Reform::Form::Dry

        property :name

        validates :name, presence: { message: "Category name can't be blank!" }
    end
end