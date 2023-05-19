class UsersController < ApplicationController
  skip_before_action :authorized, only: [:new, :create, :login, :action_login]
  # before_action :authenticate, only: [:login, :new]

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

  def destroy
  end
end
