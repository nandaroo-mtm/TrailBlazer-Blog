class ApplicationController < ActionController::Base
    include ApplicationHelper
    before_action :authorized
    helper_method :current_user
    helper_method :logged_in

    def authenticate
        if session[:user_id]
            redirect_to posts_path
        end
    end
end
