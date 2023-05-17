# require 'reform/form/dry'
require "reform/form/active_model/validations"
require "reform/form/validation/unique_validator"
module User::Contract
    class Create < Reform::Form
        # include ActiveModel::Validations

        property :name
        property :email
        property :password
        property :password_confirmation, virtual: true

        validates :name, presence:  { message: "Name field can't be blank!" }
        validates :email, presence: { message: "Email field can't be blank!" }, unique: true
        validates :password, confirmation: { message: "Password confirmation doesn't match!" }, length: { minimum: 6, too_short: "%{count} characters is the minimum allowed" }
        validates :password_confirmation, presence: true

    end
end