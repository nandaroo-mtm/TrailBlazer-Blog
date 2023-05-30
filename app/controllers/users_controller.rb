# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authorized, only: %i[logout edit show edit_password update_password] 

  def index; end

  def new
    run User::Operation::Create::Present
  end

  def create
    run User::Operation::Create do |_ctx|
      return redirect_to posts_path
    end

    render :new, status: :unprocessable_entity
  end

  def login
    run User::Operation::Login::Present
  end

  def action_login
    _ctx = run User::Operation::Login do |ctx|
      session[:user_id] = ctx[:user][:id]
      return redirect_to posts_path
    end

    flash.now[:notice] = _ctx[:email_pwd_fail]
    render :login
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path
  end

  def edit
    run User::Operation::Update::Present
  end
  
  def update
    run User::Operation::Update do |_|
      return redirect_to user_path
    end
    render :edit, status: :unprocessable_entity
  end

  def show
    run User::Operation::Show do |ctx|
      @post = ctx[:model]
      render
    end
  end

  def edit_password
    run User::Operation::UpdatePassword::Present
  end

  def update_password
    run User::Operation::UpdatePassword do
      return redirect_to user_path
    end
    render :edit_password
  end

  def destroy; end

  def password_reset_url
    run User::Operation::PasswordResetUrl::Present
  end

  def password_reset_url_action
    run User::Operation::PasswordResetUrl do |_|
      flash[:notice] = "Email sent!"
      return redirect_to password_reset_url_path
    end
    render :password_reset, status: :unprocessable_entity
  end

  def password_reset
    @user = User.find_by_id(params[:id])
    token = params[:token]
    if token != @user.reset_password_token
      flash[:notice] = "Invalid token to reset password!"
      return redirect_to login_path 
    end
    # run User::Operation::PasswordReset::Present 
    run User::Operation::UpdatePassword::Present
  end

  def password_reset_action
    run User::Operation::UpdatePassword do |_|
      return redirect_to login_path
    end
    render :password_reset, status: :unprocessable_entity
  end
  
  

end
