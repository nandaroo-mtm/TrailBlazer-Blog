module Category::Operation
    class Index < Trailblazer::Operation
      step :find_all
  
      def find_all(ctx, **)
        @categories= ::Category.all.reverse_order.page ctx[:params][:page]
        if ctx[:params][:search] && ctx[:params][:search] != ""
          @categories = @categories.where("name like ?", "%#{ctx[:params][:search]}%")
        end
        ctx[:model] = @categories;
      end
    end
end