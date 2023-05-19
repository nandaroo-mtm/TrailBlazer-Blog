class PostsController < ApplicationController
  def index
    run Post::Operation::Index do |ctx|
      @posts = ctx[:model]
      @total = @model.count
  
      render
    end
  end

  def new
    run Post::Operation::Create::Present
  end

  def create
    _ctx = run Post::Operation::Create do |ctx|
      flash[:notice] = "Post created!"
      return redirect_to posts_path
    end
    render :new, status: :unprocessable_entity
  end

  def edit
    run Post::Operation::Update::Present
  end

  def update
    _ctx = run Post::Operation::Update do |_|
      flash[:notice] = "Post updated!"
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
    flash[:notice] = "Post deleted!"
    redirect_to posts_path
  end

  def export
    run Post::Operation::ListAll do |ctx|
      @posts = ctx[:model]
      respond_to do |format|
        format.html
        format.csv { send_data @posts.to_csv, filename: "posts-#{Date.today}.csv" }
      end
    end
    # @posts = Post.all
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @posts.to_csv, filename: "posts-#{Date.today}.csv" }
    # end
  end

  def import_file 
    _ctx = run Post::Operation::Import do |ctx|
      return redirect_to posts_path
    end

    flash.now[:notice] = "Error occured!"
    render :import
  end
end
