module Category::Operation
    class Update < Trailblazer::Operation
      class Present < Trailblazer::Operation
        step Model(Category, :find_by)
        step Contract::Build(constant: Category::Contract::Create)
      end

        step Subprocess(Present)
        step Contract::Validate(key: :category)
        step Contract::Persist()
    end
  end