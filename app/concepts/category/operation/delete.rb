# app/concepts/blog_post/operation/delete.rb
module Category::Operation
    class Delete < Trailblazer::Operation
      step Model(Category, :find_by)
      step :delete
  
      def delete(ctx, model:, **)
        model.destroy
      end
    end
end