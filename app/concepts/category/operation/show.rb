module Category::Operation
  class Show < Trailblazer::Operation
    step Model(Category, :find_by)
  end
end
