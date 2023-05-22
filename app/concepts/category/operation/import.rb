require 'csv'
module Category::Operation
  class Import < Trailblazer::Operation
    # step Contract::Build(constant: Category::Contract::Import)
    # step Contract::Validate()
    step :import_csv!

    def import_csv!(_options, params:, **)
      file = File.open(params[:file])
      csv = CSV.parse(file, headers: true)

      return false if csv.count == 0 || csv['name'].include?(nil)


      csv.each do |row|
        category_hash = {}
        category_hash[:name] = row['name']
        @category = Category.create(category_hash)
      end
    end
  end
end
