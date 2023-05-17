module Post::Operation
    class Index < Trailblazer::Operation
      step :find_all
  
      def find_all(ctx, **)
        ctx[:model] = ::Post.all.reverse_order.page ctx[:params][:page]
      end
    end
end