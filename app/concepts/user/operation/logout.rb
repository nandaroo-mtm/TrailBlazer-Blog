module User::Operation
    class Logout < Trailblazer::Operation

        step :action!

        def action!(options, **)
            session[:user_id] = nil
            true
        end
    end
end
