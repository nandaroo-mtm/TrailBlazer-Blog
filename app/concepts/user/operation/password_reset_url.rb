module User::Operation
    class PasswordResetUrl < Trailblazer::Operation
      class Present < Trailblazer::Operation
        step Model(User, :new)
        step Contract::Build(constant: User::Contract::PasswordResetUrl)
      end
  
      step Subprocess(Present)
      step Contract::Validate(key: :user)
      step :generate_password_token!
  
  
      def generate_password_token!(options, params:, **)
        user = User.find_by_email(params[:user][:email])
        
        if user.present?
          user.reset_password_token = generate_token
          user.reset_password_sent_at = Time.now.utc
          user.save!
          UserMailer.with(user: user).password_reset.deliver_now
          true
        else
          options['invalid_email'] = 'Invalid Email!'
          false
        end
      end
  
      def generate_token
        SecureRandom.hex(10)
       end
    end
  end
  