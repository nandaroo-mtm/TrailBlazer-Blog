class PostsController < ApplicationController
  def index
    # @posts = Post.all.reverse_order.page params[:page]

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
end
