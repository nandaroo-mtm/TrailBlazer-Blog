module Picture::Operation
    class Create < Trailblazer::Operation
  
      step Contract::Validate(key: :picture)
      step Contract::Persist()
    end
  end
  