require 'csv'
module Category::Operation
  class Export < Trailblazer::Operation
    step :export_csv!

    def export_csv!(ctx, **)
      @categories = Category.select('id', 'name')
      column_names = %w[id name]

      ctx['model'] = CSV.generate(headers: true) do |csv|
        csv << column_names

        @categories.find_each do |record|
          csv << record.attributes.values
        end
      end
    end
  end
end
