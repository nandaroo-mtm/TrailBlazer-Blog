class CategoriesController < ApplicationController
  def index
    run Category::Operation::Index do |ctx|
      @model = ctx[:model]
      @total = @model.count
  
      render
    end
  end

  def search
    @model = Category.where("name LIKE ?", "%#{ctx[:params][:search]}%").reverse_order.page params[:page]
  end

  def create
    run Category::Operation::Create do |ctx|
      flash[:notice] = "Post created!"
      return redirect_to categories_path
    end

    render :new, status: :unprocessable_entity
  end

  def new
    run Category::Operation::Create::Present
  end

  def destroy
    run Category::Operation::Delete
    flash[:notice] = "Category deleted"
    redirect_to categories_path
  end

  def edit
    run Category::Operation::Update::Present do |ctx|
      @title  = "Editing #{ctx[:model].name}"
    end
  end

  def update
    _ctx = run Category::Operation::Update do |ctx|
      flash[:notice] = "Category updated!"
      return redirect_to categories_path
    end
  
    @title  = "Editing #{_ctx[:model].name}"
  
    render :edit, status: :unprocessable_entity
  end

  # def show
  #   run Category::Operation::Show do |ctx|
  #     @model = ctx[:model]
  #     render
  #   end
  # end

  def export
    run Category::Operation::ListAll do |ctx|
      @model = ctx[:model]
      respond_to do |format|
        format.html
        format.csv { send_data @model.to_csv, filename: "categories-#{Date.today}.csv" }
      end
    end
    # @categories = Category.all
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data @categories.to_csv, filename: "categories.csv" }
    # end
  end

  def import_file 
    _ctx = run Category::Operation::Import do |ctx|
      return redirect_to categories_path
    end

    flash.now[:notice] = "Error occured!"
    render :import
  end
end
