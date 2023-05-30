require 'reform/form/active_model/validations'
module User::Contract
  class PasswordResetUrl < Reform::Form
    # include ActiveModel::Validations
    property :email

    validates :email, presence: { message: "Email field can't be blank!" }
  end
end
