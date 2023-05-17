# require 'reform/form/dry'
require "reform/form/active_model/validations"
module User::Contract
    class Login < Reform::Form
        # include ActiveModel::Validations
        property :email
        property :password

        validates :email, presence: true
        validates :password, presence: true
        
    end
end