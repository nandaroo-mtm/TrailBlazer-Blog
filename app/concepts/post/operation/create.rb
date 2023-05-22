# include ApplicationHelper
# helper_method :current_user
module Post::Operation
  class Create < Trailblazer::Operation
    class Present < Trailblazer::Operation
      step Model(Post, :new)
      step Contract::Build(constant: Post::Contract::Create)
    end



    step Subprocess(Present)
    step :add_user_param!
    step Contract::Validate(key: :post)
    step Contract::Persist()

    def add_user_param!(ctx, **)
      ctx[:params][:post][:user_id] = ctx['current_user'][:id]
    end
  end
end
