module ApplicationHelper
    def current_user
        if session[:user_id]
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def logged_in
        !current_user.nil?
    end

    def authorized
        redirect_to login_path unless logged_in
    end
end
