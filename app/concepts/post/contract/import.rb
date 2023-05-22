# require 'reform/form/dry'
require 'reform/form/active_model/validations'
module Post::Contract
  class Import < Reform::Form
    property :file, virtual: true

    validates :file, presence: true, file_size: { less_than: 2.megabytes },
                     file_content_type: { allow: ['text/csv'] }
  end
end
