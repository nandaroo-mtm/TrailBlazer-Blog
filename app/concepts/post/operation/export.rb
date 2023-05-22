require 'csv'
module Post::Operation
  class Export < Trailblazer::Operation
    step :export_csv!

    def export_csv!(ctx, **)
      @posts = Post.select('id', 'title', 'content', 'category_id', 'user_id')

      if ctx[:params][:type].present? && ctx[:params][:type] != 'all'
        if ctx[:params][:type] == 'own'
          @posts = @posts.where(user_id: ctx[:params][:user_id])
        elsif ctx[:params][:type] == 'other'
          @posts = @posts.where.not(user_id: ctx[:params][:user_id])
        end
      end

      if ctx[:params][:search] && ctx[:params][:search] != ''
        posts_by_title = @posts.where('title like ?', "%#{ctx[:params][:search]}%")
        @posts = posts_by_title.or(@posts.where('content like ?', "%#{ctx[:params][:search]}%"))
      end


      column_names = %w[id title content category_id user_id]

      ctx['model'] = CSV.generate(headers: true) do |csv|
        csv << column_names

        @posts.find_each do |record|
          csv << record.attributes.values
        end
      end
    end
  end
end
