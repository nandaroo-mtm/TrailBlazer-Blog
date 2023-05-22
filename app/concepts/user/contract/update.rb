# require 'reform/form/dry'
require 'reform/form/active_model/validations'
require 'reform/form/validation/unique_validator'
module User::Contract
  class Update < Reform::Form
    property :name
    property :email
    property :phone
    property :address

    validates :name, presence:  { message: "Name field can't be blank!" }
    validates :email, presence: { message: "Email field can't be blank!" }, unique: true
    validates :phone, numericality: true, allow_blank: true, length: { minimum: 10, maximum: 13 }
    validates :address, allow_blank: true, length: { maximum: 255 }
  end
end
