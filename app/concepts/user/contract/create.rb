# require 'reform/form/dry'
require 'reform/form/active_model/validations'
require 'reform/form/validation/unique_validator'
module User::Contract
  class Create < Reform::Form
    # include ActiveModel::Validations

    property :name
    property :email
    property :phone
    property :address
    property :password
    property :password_confirmation, virtual: true

    validates :name, presence:  { message: "Name field can't be blank!" }
    validates :email, presence: { message: "Email field can't be blank!" }, unique: true
    validates :phone, numericality: true, allow_blank: true, length: { minimum: 10, maximum: 13 }
    validates :address, allow_blank: true, length: { maximum: 255 }
    validates :password, confirmation: { message: "Password confirmation doesn't match!" },
                         length: { minimum: 6, too_short: '%<count>s characters is the minimum allowed' }
    validates :password_confirmation, presence: true
  end
end
