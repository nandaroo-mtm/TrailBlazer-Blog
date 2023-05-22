module Post::Operation
  class Delete < Trailblazer::Operation
    step Model(Post, :find_by)
    step :delete

    def delete(_ctx, model:, **)
      model.destroy
    end
  end
end
