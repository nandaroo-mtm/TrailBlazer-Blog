# frozen_string_literal: true

class CategoriesController < ApplicationController
  def index
    run Category::Operation::Index do |ctx|
      @model = ctx[:model]
      @total = @model.count

      render
    end
  end

  def create
    run Category::Operation::Create do |_ctx|
      flash[:notice] = 'Category created!'
      return redirect_to categories_path
    end

    render :new, status: :unprocessable_entity
  end

  def new
    run Category::Operation::Create::Present
  end

  def destroy
    run Category::Operation::Delete
    flash[:notice] = 'Category deleted'
    redirect_to categories_path
  end

  def edit
    run Category::Operation::Update::Present do |ctx|
      @title = "Editing #{ctx[:model].name}"
    end
  end

  def update
    _ctx = run Category::Operation::Update do |_ctx|
      flash[:notice] = 'Category updated!'
      return redirect_to categories_path
    end

    @title = "Editing #{_ctx[:model].name}"

    render :edit, status: :unprocessable_entity
  end

  # def show
  #   run Category::Operation::Show do |ctx|
  #     @model = ctx[:model]
  #     render
  #   end
  # end

  def export
    run Category::Operation::Export do |ctx|
      model = ctx[:model]
      respond_to do |format|
        format.html
        format.csv { send_data model, filename: "categories-#{Date.today}.csv" }
      end
    end
  end

  def import_file
    run Category::Operation::Import do |_ctx|
      return redirect_to categories_path
    end

    flash.now[:notice] = 'Error occured!'
    render :import
  end
end
