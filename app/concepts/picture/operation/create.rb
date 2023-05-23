module Picture::Operation
    class Create < Trailblazer::Operation
    #   class Present < Trailblazer::Operation
    #     step Model(Category, :new)
    #     step Contract::Build(constant: Category::Contract::Create)
    #   end
  
      step Subprocess(Present)
      step Contract::Validate()
      step Contract::Persist()

    end
  end
  