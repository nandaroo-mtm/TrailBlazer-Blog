# require 'reform/form/dry'
require 'reform/form/active_model/validations'
module User::Contract
  class UpdatePassword < Reform::Form
    # include ActiveModel::Validations

    property :password
    property :password_confirmation, virtual: true

    validates :password, confirmation: { message: "Password confirmation doesn't match!" },
                         length: { minimum: 6, too_short: '%<count>s characters is the minimum allowed' }
    validates :password_confirmation, presence: true
  end
end
