# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    if params[:type].present?
      params[:user_id] = current_user.id
      session['type'] = params[:type]
    end

    session['search'] = params[:search]
    

    run Post::Operation::Index do |ctx|
      @posts = ctx[:model]
      $test = ctx[:model]
      @total = @model.count

      render
    end
  end

  def new
    run Post::Operation::Create::Present
  end

  def create
    run(Post::Operation::Create, current_user:) do |_ctx|
      flash[:notice] = 'Post created!'
      return redirect_to posts_path
    end
    render :new, status: :unprocessable_entity
  end

  def edit
    run Post::Operation::Update::Present
  end

  def update
    run Post::Operation::Update do |_|
      flash[:notice] = 'Post updated!'
      return redirect_to posts_path
    end
    render :edit, status: :unprocessable_entity
  end

  def show
    run Post::Operation::Show do |ctx|
      @post = ctx[:model]
      render
    end
  end

  def destroy
    run Post::Operation::Delete
    flash[:notice] = 'Post deleted!'
    redirect_to posts_path
  end

  def export
    if session[:type].present?
      params[:user_id] = current_user.id
      params[:type] = session[:type]
    end

    params[:search] = session[:search] if session[:search].present?

    run Post::Operation::Export do |ctx|
      model = ctx[:model]
      respond_to do |format|
        format.html
        format.csv { send_data model, filename: "posts-#{Date.today}.csv" }
      end
    end
  end


  def import_file

    run Post::Operation::Import do |_ctx|
      return redirect_to posts_path
    end
    flash.now[:notice] = 'Error occured!'
    render :import
  end
end
