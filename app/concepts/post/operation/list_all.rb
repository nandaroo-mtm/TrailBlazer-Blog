module Post::Operation
    class ListAll < Trailblazer::Operation
      step :find_all
  
      def find_all(ctx, **)
        ctx[:model]= ::Post.all
      end
    end
end