module Category::Operation
  class ListAll < Trailblazer::Operation
    step :find_all

    def find_all(ctx, **)
      ctx[:model] = ::Category.all
    end
  end
end
