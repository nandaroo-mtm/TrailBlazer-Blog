module Category::Operation
    class Create < Trailblazer::Operation
        class Present < Trailblazer::Operation
            step Model(Category, :new)
            step Contract::Build(constant: Category::Contract::Create)
        end
        
        step Subprocess(Present)
        step Contract::Validate(key: :category)
        step Contract::Persist()
        step :notify!

        def notify!(ctx, model:, **)
            ctx["result.notify"] = Rails.logger.info("New blog post #{model.name}.")
        end
    end
end
