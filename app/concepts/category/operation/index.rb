module Category::Operation
    class Index < Trailblazer::Operation
      step :find_all
  
      def find_all(ctx, **)
        ctx[:model] = ::Category.all.reverse_order
      end
    end
end