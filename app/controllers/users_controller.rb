class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :login, :action_login]
  # before_action :authenticate, only: [:login]

  def index
  end

  def new
    run User::Operation::Create::Present
  end

  def create
    _ctx = run User::Operation::Create do |ctx|
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

  def destroy
  end
end
