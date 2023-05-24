# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    if params[:type].present?
      params[:user_id] = current_user.id
      session['type'] = params[:type]
    end

    session['search'] = params[:search]
    # if params[:search].present?
    #   params[:user_id] = current_user.id
    #   session['type'] = params[:type]
    # end

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
    ctx = run(Post::Operation::Create, current_user:) do |_ctx|
      flash[:notice] = 'Post created!'
      return redirect_to posts_path
    end
    @post = ctx[:model]
    binding.pry
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

  # def edit
  #   run Post::Operation::Import::Present
  # end

  def import_file
    # return redirect_to request.referer, notice: 'No file added' if params[:file].nil?
    # return redirect_to request.referer, notice: 'Only CSV files allowed' unless params[:file].content_type == 'text/csv'

    run Post::Operation::Import do |_ctx|
      return redirect_to posts_path
    end
    # binding.pry
    flash.now[:notice] = 'Error occured!'
    render :import
  end
end
