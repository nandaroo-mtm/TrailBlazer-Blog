# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_action :authorized
  helper_method :current_user
  helper_method :logged_in

  def authenticate
    return unless session[:user_id].present?

    redirect_to posts_path
  end
end
