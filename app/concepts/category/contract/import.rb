require "reform/form/active_model/validations"
module Category::Contract
    class Import < Reform::Form
        # feature Reform::Form::Dry

        property :file, virtual: true

        validates :file, presence: true

    end
end