# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[new create login action_login]
  # before_action :authenticate, only: %i[login new]

  def index; end

  def new
    run User::Operation::Create::Present
  end

  def create
    run User::Operation::Create do |_ctx|
      @user = _ctx[:model] 
      picture_hash={}
      picture_hash[:image] = _ctx['params']['user']['pictures_attributes']['image']
      picture_hash[:imageable] = @user
      @picture = Picture.new(picture_hash)
      @picture.save
      return redirect_to login_path
    end

    render :new, status: :unprocessable_entity
  end

  def login
    run User::Operation::Login::Present
  end

  def action_login
    run User::Operation::Login do |ctx|
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
    run User::Operation::Update do |ctx|
      if ctx['params']['user']['pictures_attributes'].present?
        picture = ctx[:model].pictures[0]
        picture_hash={}
        picture_hash[:image] = ctx['params']['user']['pictures_attributes']['image']
        picture.update(picture_hash)
      end
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
end
